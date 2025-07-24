//
//  CatsRouter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

protocol CatsRoutingLogic { }

protocol CatsDataPassing {
    var dataStore: CatsDataStore? { get }
}

final class CatsRouter: NSObject, CatsRoutingLogic, CatsDataPassing {
    
    // MARK: Properties
    weak var viewController: CatsViewController?
    var dataStore: CatsDataStore?
    
} 
