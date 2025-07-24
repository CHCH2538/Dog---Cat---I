//
//  DogsModels.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

enum Dogs {
    enum LoadImages {
        struct Request {
            let count: Int
        }
        
        struct Response {
            let images: [DogImageResponse]
            let timestamp: Date
            let isSuccess: Bool
            let error: Error?
        }
        
        struct ViewModel {
            let displayedImages: [DogImageDisplayData]
            let isLoading: Bool
            let errorMessage: String?
        }
    }
    
    enum ReloadConcurrent {
        struct Request {
            let count: Int
        }
        
        struct Response {
            let images: [DogImageResponse]
            let timestamps: [Date]
            let isSuccess: Bool
            let error: Error?
        }
        
        struct ViewModel {
            let displayedImages: [DogImageDisplayData]
            let isLoading: Bool
            let errorMessage: String?
        }
    }
    
    enum ReloadSequential {
        struct Request {
            let count: Int
        }
        
        struct Response {
            let images: [DogImageResponse]
            let timestamps: [Date]
            let isSuccess: Bool
            let error: Error?
        }
        
        struct ViewModel {
            let displayedImages: [DogImageDisplayData]
            let isLoading: Bool
            let errorMessage: String?
        }
    }
}

struct DogImageDisplayData {
    let id: String
    let imageURL: String
    let title: String
    let timestamp: String
    let isLoading: Bool
}

 
