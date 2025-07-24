//
//  UIImageViewExtension.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

extension UIImageView {
    
    func makeCircular() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
}
