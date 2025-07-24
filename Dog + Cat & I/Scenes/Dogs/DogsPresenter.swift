//
//  DogsPresenter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol DogsPresentationLogic {
    func presentDogImages(response: Dogs.LoadImages.Response)
    func presentConcurrentReload(response: Dogs.ReloadConcurrent.Response)
    func presentSequentialReload(response: Dogs.ReloadSequential.Response)
}

final class DogsPresenter: DogsPresentationLogic {
    
    // MARK: Properties
    weak var viewController: DogsDisplayLogic?
    
    // MARK: Presentation Logic
    func presentDogImages(response: Dogs.LoadImages.Response) {
        if response.isSuccess {
            let imageData = createImageDisplayData(from: response.images, timestamp: response.timestamp)
            let viewModel = Dogs.LoadImages.ViewModel(
                displayedImages: imageData,
                isLoading: false,
                errorMessage: nil
            )
            viewController?.displayDogImages(viewModel: viewModel)
        } else {
            let errorMessage = response.error?.localizedDescription ?? "Failed to load dog images"
            let viewModel = Dogs.LoadImages.ViewModel(
                displayedImages: [],
                isLoading: false,
                errorMessage: errorMessage
            )
            viewController?.displayDogImages(viewModel: viewModel)
        }
    }
    
    func presentConcurrentReload(response: Dogs.ReloadConcurrent.Response) {
        if response.isSuccess {
            let imageData = createImageDisplayDataWithIndividualTimestamps(from: response.images, timestamps: response.timestamps)
            let viewModel = Dogs.ReloadConcurrent.ViewModel(
                displayedImages: imageData,
                isLoading: false,
                errorMessage: nil
            )
            viewController?.displayConcurrentReload(viewModel: viewModel)
        } else {
            let errorMessage = response.error?.localizedDescription ?? "Failed to load dog images"
            let viewModel = Dogs.ReloadConcurrent.ViewModel(
                displayedImages: [],
                isLoading: false,
                errorMessage: errorMessage
            )
            viewController?.displayConcurrentReload(viewModel: viewModel)
        }
    }
    
    func presentSequentialReload(response: Dogs.ReloadSequential.Response) {
        if response.isSuccess {
            let imageData = createImageDisplayDataWithIndividualTimestamps(from: response.images, timestamps: response.timestamps)
            let viewModel = Dogs.ReloadSequential.ViewModel(
                displayedImages: imageData,
                isLoading: false,
                errorMessage: nil
            )
            viewController?.displaySequentialReload(viewModel: viewModel)
        } else {
            let errorMessage = response.error?.localizedDescription ?? "Failed to load dog images"
            let viewModel = Dogs.ReloadSequential.ViewModel(
                displayedImages: [],
                isLoading: false,
                errorMessage: errorMessage
            )
            viewController?.displaySequentialReload(viewModel: viewModel)
        }
    }
    
    // MARK: Private Formatting Methods
    private func createImageDisplayData(from images: [DogImageResponse], timestamp: Date) -> [DogImageDisplayData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let timestampString = dateFormatter.string(from: timestamp)
        
        return images.enumerated().map { index, image in
            DogImageDisplayData(
                id: image.id,
                imageURL: image.imageURL,
                title: "Dog#\(index + 1)",
                timestamp: timestampString,
                isLoading: false
            )
        }
    }
    
    private func createImageDisplayDataWithIndividualTimestamps(from images: [DogImageResponse], timestamps: [Date]) -> [DogImageDisplayData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        return zip(images, timestamps).enumerated().map { index, tuple in
            let (image, timestamp) = tuple
            let timestampString = dateFormatter.string(from: timestamp)
            
            return DogImageDisplayData(
                id: image.id,
                imageURL: image.imageURL,
                title: "Dog#\(index + 1)",
                timestamp: timestampString,
                isLoading: false
            )
        }
    }
    
} 
