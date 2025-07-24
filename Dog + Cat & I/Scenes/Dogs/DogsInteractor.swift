//
//  DogsInteractor.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol DogsBusinessLogic {
    func loadDogImages(request: Dogs.LoadImages.Request)
    func reloadConcurrent(request: Dogs.ReloadConcurrent.Request)
    func reloadSequential(request: Dogs.ReloadSequential.Request)
}

protocol DogsDataStore {
    var dogImages: [DogImageResponse] { get set }
    var lastLoadTimestamp: Date? { get set }
}

final class DogsInteractor: DogsBusinessLogic, DogsDataStore {
    
    // MARK: Data Store
    var dogImages: [DogImageResponse] = []
    var timestamps: [Date] = []
    var lastLoadTimestamp: Date?
    
    // MARK: Properties
    var presenter: DogsPresentationLogic?
    var worker: DogsWorkerLogic?
    
    private let defaultDogCount = 3
    
    // MARK: Business Logic
    func loadDogImages(request: Dogs.LoadImages.Request) {
        let timestamp = Date()
        
        Task {
            do {
                let images = try await worker?.fetchDogImagesConcurrently(count: request.count) ?? []
                
                await MainActor.run { [weak self] in
                    self?.dogImages = images
                    self?.lastLoadTimestamp = timestamp
                    
                    let response = Dogs.LoadImages.Response(
                        images: images,
                        timestamp: timestamp,
                        isSuccess: true,
                        error: nil
                    )
                    self?.presenter?.presentDogImages(response: response)
                }
            } catch {
                await MainActor.run { [weak self] in
                    let response = Dogs.LoadImages.Response(
                        images: [],
                        timestamp: timestamp,
                        isSuccess: false,
                        error: error
                    )
                    self?.presenter?.presentDogImages(response: response)
                }
            }
        }
    }
    
    func reloadConcurrent(request: Dogs.ReloadConcurrent.Request) {
        let timestamp = Date()
        
        Task {
            do {
                await MainActor.run { [weak self] in
                    self?.dogImages = []
                    self?.timestamps = []
                    self?.lastLoadTimestamp = timestamp
                }
                
                try await withThrowingTaskGroup(of: DogImageResponse.self) { group in
                    for _ in 0..<request.count {
                        group.addTask {
                            try await self.worker?.fetchDogImage() ?? DogImageResponse(message: "", status: "")
                        }
                    }
                    
                    for try await image in group {
                        let imageTimestamp = Date()
                        
                        await MainActor.run { [weak self] in
                            self?.dogImages.append(image)
                            self?.timestamps.append(imageTimestamp)
                            
                            let response = Dogs.ReloadConcurrent.Response(
                                images: self?.dogImages ?? [],
                                timestamps: self?.timestamps ?? [],
                                isSuccess: true,
                                error: nil
                            )
                            self?.presenter?.presentConcurrentReload(response: response)
                        }
                    }
                }
            } catch {
                await MainActor.run { [weak self] in
                    let response = Dogs.ReloadConcurrent.Response(
                        images: [],
                        timestamps: [],
                        isSuccess: false,
                        error: error
                    )
                    self?.presenter?.presentConcurrentReload(response: response)
                }
            }
        }
    }
    
    func reloadSequential(request: Dogs.ReloadSequential.Request) {
        let timestamp = Date()
        
        Task {
            do {
                await MainActor.run { [weak self] in
                    self?.dogImages = []
                    self?.timestamps = []
                    self?.lastLoadTimestamp = timestamp
                }
                
                for _ in 0..<request.count {
                    let image = try await worker?.fetchDogImage() ?? DogImageResponse(message: "", status: "")
                    let imageTimestamp = Date()
                    
                    await MainActor.run { [weak self] in
                        self?.dogImages.append(image)
                        self?.timestamps.append(imageTimestamp)
                        
                        let response = Dogs.ReloadSequential.Response(
                            images: self?.dogImages ?? [],
                            timestamps: self?.timestamps ?? [],
                            isSuccess: true,
                            error: nil
                        )
                        self?.presenter?.presentSequentialReload(response: response)
                    }
                }
            } catch {
                await MainActor.run { [weak self] in
                    let response = Dogs.ReloadSequential.Response(
                        images: [],
                        timestamps: [],
                        isSuccess: false,
                        error: error
                    )
                    self?.presenter?.presentSequentialReload(response: response)
                }
            }
        }
    }
     
}

 
