//
//  CatsPresenter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol CatsPresentationLogic {
    func presentCatBreeds(response: Cats.LoadBreeds.Response)
    func presentToggledBreed(response: Cats.ToggleBreedExpansion.Response)
}

final class CatsPresenter: CatsPresentationLogic {
    
    // MARK: Properties
    weak var viewController: CatsDisplayLogic?
    
    // MARK: Presentation Logic
    func presentCatBreeds(response: Cats.LoadBreeds.Response) {
        if response.isSuccess {
            let items = createFlatDataSource(from: response.catBreeds)
            let viewModel = Cats.LoadBreeds.ViewModel(
                items: items,
                isLoading: false,
                errorMessage: nil
            )
            viewController?.displayCatBreeds(viewModel: viewModel)
        } else {
            let errorMessage = response.error?.localizedDescription ?? "Failed to load cat breeds"
            let viewModel = Cats.LoadBreeds.ViewModel(
                items: [],
                isLoading: false,
                errorMessage: errorMessage
            )
            viewController?.displayCatBreeds(viewModel: viewModel)
        }
    }
    
    func presentToggledBreed(response: Cats.ToggleBreedExpansion.Response) {
        let viewModel = Cats.ToggleBreedExpansion.ViewModel(items: response.items)
        viewController?.displayToggledBreed(viewModel: viewModel)
    }
    
    // MARK: Private Formatting Methods
    private func createFlatDataSource(from breeds: [CatBreed]) -> [CatsItem] {
        return breeds.map { breed in
            CatsItem.header(breed: breed, isExpanded: false)
        }
    }
    
} 

