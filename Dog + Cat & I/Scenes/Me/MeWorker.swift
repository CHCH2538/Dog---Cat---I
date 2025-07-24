//
//  MeWorker.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation
import Alamofire

protocol MeWorkerLogic {
    func fetchRandomUser() async throws -> RandomUserResponse
}

final class MeWorker: MeWorkerLogic {
    
    private let baseURL = "https://randomuser.me"
    private let endpoint = "/api/"
    
    // MARK: Public Methods
    func fetchRandomUser() async throws -> RandomUserResponse {
        let url = baseURL + endpoint
        
        let response = await AF.request(url)
            .validate()
            .serializingDecodable(RandomUserResponse.self)
            .response
        
        switch response.result {
        case .success(let userCollection):
            return userCollection
        case .failure(let error):
            throw error
        }
    }
    
} 
 
