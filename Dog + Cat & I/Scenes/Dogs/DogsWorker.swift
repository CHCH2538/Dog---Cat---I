//
//  DogsWorker.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation
import Alamofire

protocol DogsWorkerLogic {
    func fetchDogImage() async throws -> DogImageResponse
    func fetchDogImagesConcurrently(count: Int) async throws -> [DogImageResponse]
    func fetchDogImagesSequentially(count: Int, delay: TimeInterval) async throws -> [DogImageResponse]
}

final class DogsWorker: DogsWorkerLogic {
    
    private let baseURL = "https://dog.ceo"
    private let endpoint = "/api/breeds/image/random"

    
    func fetchDogImage() async throws -> DogImageResponse {
        let url = baseURL + endpoint
        
        let response = await AF.request(url)
            .validate()
            .serializingDecodable(DogImageResponse.self)
            .response
        
        switch response.result {
        case .success(let dogImage):
            return dogImage
        case .failure(let error):
            throw error
        }
    }
    
    func fetchDogImagesConcurrently(count: Int) async throws -> [DogImageResponse] {
        return try await withThrowingTaskGroup(of: DogImageResponse.self) { group in
            for _ in 0..<count {
                group.addTask {
                    try await self.fetchDogImage()
                }
            }
            
            var results: [DogImageResponse] = []
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }
    
    func fetchDogImagesSequentially(count: Int, delay: TimeInterval) async throws -> [DogImageResponse] {
        var results: [DogImageResponse] = []
        
        for index in 0..<count {
            if index > 0 {
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            }
            let result = try await fetchDogImage()
            results.append(result)
        }
        
        return results
    }

} 
