//
//  MeInteractor.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol MeBusinessLogic {
    func loadProfile(request: Me.LoadProfile.Request)
}

protocol MeDataStore {
    var user: RandomUser? { get set }
}

final class MeInteractor: MeBusinessLogic, MeDataStore {
    
    // MARK: Data Store
    var user: RandomUser?
    
    // MARK: Properties
    var presenter: MePresentationLogic?
    var worker: MeWorkerLogic?
    
    // MARK: Business Logic
    func loadProfile(request: Me.LoadProfile.Request) {
        Task {
            do {
                let userCollection = try await worker?.fetchRandomUser()
                let randomUser = userCollection?.results.first
                
                await MainActor.run { [weak self] in
                    self?.user = randomUser
                    
                    let response = Me.LoadProfile.Response(
                        user: randomUser,
                        isSuccess: true,
                        error: nil
                    )
                    self?.presenter?.presentProfile(response: response)
                }
            } catch {
                await MainActor.run { [weak self] in
                    let response = Me.LoadProfile.Response(
                        user: nil,
                        isSuccess: false,
                        error: error
                    )
                    self?.presenter?.presentProfile(response: response)
                }
            }
        }
    }
    
}

 
