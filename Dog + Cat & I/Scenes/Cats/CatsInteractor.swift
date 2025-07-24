//
//  CatsInteractor.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol CatsBusinessLogic {
    func loadCatBreeds(request: Cats.LoadBreeds.Request)
    func toggleBreedExpansion(request: Cats.ToggleBreedExpansion.Request)
}

protocol CatsDataStore {
    var catBreeds: [CatBreed] { get set }
    var expandedBreedIds: Set<String> { get set }
}

final class CatsInteractor: CatsBusinessLogic, CatsDataStore {
    
    // MARK: Data Store
    var catBreeds: [CatBreed] = []
    var expandedBreedIds: Set<String> = []
    
    // MARK: Properties
    var presenter: CatsPresentationLogic?
    var worker: CatsWorkerLogic?
    
    // MARK: Business Logic
    func loadCatBreeds(request: Cats.LoadBreeds.Request) {
        Task {
            do {
                let breedsCollection = try await worker?.fetchCatBreeds()
                let breeds = breedsCollection?.data ?? []
                
                await MainActor.run { [weak self] in
                    self?.catBreeds = breeds
                    self?.expandedBreedIds.removeAll()
                    
                    let response = Cats.LoadBreeds.Response(
                        catBreeds: breeds,
                        isSuccess: true,
                        error: nil
                    )
                    self?.presenter?.presentCatBreeds(response: response)
                }
            } catch {
                await MainActor.run { [weak self] in
                    let response = Cats.LoadBreeds.Response(
                        catBreeds: [],
                        isSuccess: false,
                        error: error
                    )
                    self?.presenter?.presentCatBreeds(response: response)
                }
            }
        }
    }
    
    func toggleBreedExpansion(request: Cats.ToggleBreedExpansion.Request) {
        let breedId = request.breedId
        
        if expandedBreedIds.contains(breedId) {
            expandedBreedIds.remove(breedId)
        } else {
            expandedBreedIds.insert(breedId)
        }
        
        let response = Cats.ToggleBreedExpansion.Response(items: createFlatDataSource())
        presenter?.presentToggledBreed(response: response)
    }
    
    // MARK: Private Methods
    private func createFlatDataSource() -> [CatsItem] {
        var items: [CatsItem] = []
        
        for breed in catBreeds {
            let isExpanded = expandedBreedIds.contains(breed.id)
            items.append(.header(breed: breed, isExpanded: isExpanded))
            
            if isExpanded {
                items.append(.content(breed: breed))
            }
        }
        
        return items
    }
    
}
