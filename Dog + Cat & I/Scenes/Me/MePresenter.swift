//
//  MePresenter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import Foundation

protocol MePresentationLogic {
    func presentProfile(response: Me.LoadProfile.Response)
}

final class MePresenter: MePresentationLogic {
    
    // MARK: Properties
    weak var viewController: MeDisplayLogic?
    
    // MARK: Presentation Logic
    func presentProfile(response: Me.LoadProfile.Response) {
        if response.isSuccess, let user = response.user {
            let displayedProfile = MeProfileViewModel(
                profileImageURL: user.profileImageURL,
                title: user.name.title,
                firstName: user.name.first,
                lastName: user.name.last,
                dateOfBirth: user.formattedDateOfBirth,
                age: String(user.age),
                gender: user.gender,
                nationality: user.nat,
                phone: user.mobileNumber,
                address: user.address
            )
            
            let viewModel = Me.LoadProfile.ViewModel(
                displayedProfile: displayedProfile,
                isLoading: false,
                errorMessage: nil
            )
            viewController?.displayProfile(viewModel: viewModel)
        } else {
            let errorMessage = response.error?.localizedDescription ?? "Failed to load profile"
            let viewModel = Me.LoadProfile.ViewModel(
                displayedProfile: nil,
                isLoading: false,
                errorMessage: errorMessage
            )
            viewController?.displayProfile(viewModel: viewModel)
        }
    }
    
} 
