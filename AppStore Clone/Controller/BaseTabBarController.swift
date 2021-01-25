//
//  BaseTabBarController.swift
//  AppStore Clone
//
//  Created by Harleen Singh on 26/01/21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         
        viewControllers = [
            
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today"),
            createNavController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppSearchController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Search", imageName: "search"),
            
        
        ]
                        
        
        
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
        
        
        
    }
}
