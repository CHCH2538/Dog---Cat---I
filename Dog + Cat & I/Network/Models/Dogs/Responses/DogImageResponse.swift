//
//  DogImageResponse.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

struct DogImageResponse: Codable, Identifiable {
    let message: String
    let status: String
    
    var id: String { message }
    var imageURL: String { message }
} 
