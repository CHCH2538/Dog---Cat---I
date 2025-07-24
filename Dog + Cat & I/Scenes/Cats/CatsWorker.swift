//
//  CatsWorker.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation
import Alamofire

protocol CatsWorkerLogic {
    func fetchCatBreeds() async throws -> CatBreedsResponse
}

final class CatsWorker: CatsWorkerLogic {
    
    private let baseURL = "https://catfact.ninja"
    private let endpoint = "/breeds"
    
    // MARK: Public Methods
    func fetchCatBreeds() async throws -> CatBreedsResponse {
        let url = baseURL + endpoint
        
        let response = await AF.request(url)
            .validate()
            .serializingDecodable(CatBreedsResponse.self)
            .response
        
        switch response.result {
        case .success(let breedsResponse):
            return breedsResponse
        case .failure(let error):
            throw error
        }
    }
    
} 
