//
//  RandomUser.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [RandomUser]
    let info: RandomUserInfo
}

struct RandomUser: Codable {
    
    let gender: String
    let name: RandomUserName
    let location: RandomUserLocation
    let email: String
    let login: RandomUserLogin
    let dob: RandomUserDateOfBirth
    let registered: RandomUserRegistered
    let phone: String
    let cell: String
    let id: RandomUserId
    let picture: RandomUserPicture
    let nat: String

    var age: Int {
        return dob.age
    }
    
    var profileImageURL: String {
        return picture.large
    }
    
    var mobileNumber: String {
        return cell
    }
    
    var address: String {
        let loc = location
        return "\(loc.street.number) \(loc.street.name), \(loc.city), \(loc.state), \(loc.country), \(loc.postcode)"
    }
    
    var formattedDateOfBirth: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: dob.date) {
            return outputFormatter.string(from: date)
        }
        return dob.date
    }
    
    var genderIcon: String {
        return gender.lowercased() == "male" ? "male-gender" : "femal-gender"
    }
}

struct RandomUserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct RandomUserLocation: Codable {
    let street: RandomUserStreet
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: RandomUserCoordinates
    let timezone: RandomUserTimezone
}

struct RandomUserStreet: Codable {
    let number: Int
    let name: String
}

struct RandomUserCoordinates: Codable {
    let latitude: String
    let longitude: String
}

struct RandomUserTimezone: Codable {
    let offset: String
    let description: String
}

struct RandomUserLogin: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct RandomUserDateOfBirth: Codable {
    let date: String
    let age: Int
}

struct RandomUserRegistered: Codable {
    let date: String
    let age: Int
}

struct RandomUserId: Codable {
    let name: String?
    let value: String?
}

struct RandomUserPicture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct RandomUserInfo: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
} 
