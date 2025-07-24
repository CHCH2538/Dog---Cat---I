//
//  MeRouter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

protocol MeRoutingLogic { }

protocol MeDataPassing {
    var dataStore: MeDataStore? { get }
}

final class MeRouter: NSObject, MeRoutingLogic, MeDataPassing {
    
    // MARK: Properties
    weak var viewController: MeViewController?
    var dataStore: MeDataStore?

} 
