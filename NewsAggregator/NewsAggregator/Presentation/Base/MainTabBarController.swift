//
//  NewsViewController.swift
//  NewsAggregator
//
//  Created by Natalia Pashkova on 26.04.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        self.tabBar.tintColor = .systemYellow
        let newsViewController = createNavigationController(vc: NewsViewController(), titleName: "News", imageName: "newspaper")
        let selectedNewsViewController = createNavigationController(vc: SelectedNewsViewController(), titleName: "Selected News", imageName: "star")
        viewControllers = [newsViewController, selectedNewsViewController]
    }
    
    func createNavigationController(vc: UIViewController, titleName: String, imageName: String) -> UINavigationController{
        let item = UITabBarItem(title: titleName,
                                image: UIImage(systemName: imageName)?.withAlignmentRectInsets(.zero),
                                tag: 0)
        item.titlePositionAdjustment = .zero
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.navigationBar.tintColor = .systemYellow
        return navController
    }

}
