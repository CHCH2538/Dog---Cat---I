//
//  CatsModels.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

enum Cats {
    enum LoadBreeds {
        struct Request { }
        
        struct Response {
            let catBreeds: [CatBreed]
            let isSuccess: Bool
            let error: Error?
        }
        
        struct ViewModel {
            let items: [CatsItem]
            let isLoading: Bool
            let errorMessage: String?
        }
    }
    
    enum ToggleBreedExpansion {
        struct Request { 
            let breedId: String 
        }
        
        struct Response {
            let items: [CatsItem]
        }
        
        struct ViewModel { 
            let items: [CatsItem]
        }
    }
}

enum CatsItem {
    case header(breed: CatBreed, isExpanded: Bool)
    case content(breed: CatBreed)
}

 
