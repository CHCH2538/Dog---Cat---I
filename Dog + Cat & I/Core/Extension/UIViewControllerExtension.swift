//
//  UIViewControllerExtension.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

extension UIViewController {
    
    @discardableResult
    func showModalLoading(message: String = "Loading...") -> LoadingOverlayViewController {
        return LoadingOverlayManager.shared.showModalLoading(
            from: self,
            message: message
        )
    }
    
    func hideModalLoading(_ loadingViewController: LoadingOverlayViewController) {
        LoadingOverlayManager.shared.hideModalLoading(loadingViewController)
    }
    
}
