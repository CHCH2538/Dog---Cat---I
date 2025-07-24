//
//  CatBreedResponse.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

struct CatBreedsResponse: Codable {
    let currentPage: Int
    let data: [CatBreed]
    let total: Int
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case total
    }
}

struct CatBreed: Codable, Identifiable {
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String
    
    var id: String { breed }
} 
