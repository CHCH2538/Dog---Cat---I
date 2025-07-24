//
//  MeModels.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

enum Me {
    enum LoadProfile {
        struct Request { }
        
        struct Response {
            let user: RandomUser?
            let isSuccess: Bool
            let error: Error?
        }
        
        struct ViewModel {
            let displayedProfile: MeProfileViewModel?
            let isLoading: Bool
            let errorMessage: String?
        }
    }
}

struct MeProfileViewModel {
    let profileImageURL: String
    let title: String
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    let age: String
    let gender: String
    let nationality: String
    let phone: String
    let address: String
} 
