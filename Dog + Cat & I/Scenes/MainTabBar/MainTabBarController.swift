//
//  MainTabBarController.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    // MARK: Setup
    private func setupTabBar() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        
        selectedIndex = 0
    }
    
    private func setupViewControllers() {
        let dogsViewController = createDogsViewController()
        let catsViewController = createCatsViewController()
        let meViewController = createMeViewController()
        
        viewControllers = [
            dogsViewController,
            catsViewController,
            meViewController
        ]
    }
    
    // MARK: Private Methods
    private func createDogsViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "DogsViewController", bundle: nil)
        guard let dogsVC = storyboard.instantiateViewController(withIdentifier: "DogsViewController") as? DogsViewController else {
            return UINavigationController()
        }
        
        dogsVC.navigationItem.title = "Dog + Cat & I"
        
        let navigationController = UINavigationController(rootViewController: dogsVC)
        navigationController.tabBarItem = UITabBarItem(
            title: "Dogs",
            image: UIImage(named: "dog")?.resized(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal),
            tag: 0
        )
        
        setupNavigationBar(navigationController: navigationController)
        
        return navigationController
    }
    
    private func createCatsViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "CatsViewController", bundle: nil)
        guard let catsVC = storyboard.instantiateViewController(withIdentifier: "CatsViewController") as? CatsViewController else {
            return UINavigationController()
        }
        
        catsVC.navigationItem.title = "Dog + Cat & I"
        
        let navigationController = UINavigationController(rootViewController: catsVC)
        navigationController.tabBarItem = UITabBarItem(
            title: "Cats",
            image: UIImage(named: "cat")?.resized(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal),
            tag: 1
        )
        
        setupNavigationBar(navigationController: navigationController)
        
        return navigationController
    }
    
    private func createMeViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "MeViewController", bundle: nil)
        guard let meVC = storyboard.instantiateViewController(withIdentifier: "MeViewController") as? MeViewController else {
            return UINavigationController()
        }
        
        meVC.navigationItem.title = "Dog + Cat & I"
        
        let navigationController = UINavigationController(rootViewController: meVC)
        navigationController.tabBarItem = UITabBarItem(
            title: "Me",
            image: UIImage(named: "profile")?.resized(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal),
            tag: 2
        )
        
        setupNavigationBar(navigationController: navigationController)
        
        return navigationController
    }
    
    private func setupNavigationBar(navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = .systemBackground
        navigationController.navigationBar.tintColor = .systemBlue
    }
    
} 
