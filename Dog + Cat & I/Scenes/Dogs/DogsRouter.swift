//
//  DogsRouter.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

protocol DogsRoutingLogic { }

protocol DogsDataPassing {
    var dataStore: DogsDataStore? { get }
}

final class DogsRouter: NSObject, DogsRoutingLogic, DogsDataPassing {
    
    // MARK: Properties
    weak var viewController: DogsViewController?
    var dataStore: DogsDataStore?

} 
