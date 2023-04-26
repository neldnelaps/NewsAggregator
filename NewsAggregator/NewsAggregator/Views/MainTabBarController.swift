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
        view.backgroundColor = UIColor.white
        setupTabBar()
    }
    
    func setupTabBar() {
        let newsViewController = createNavigationController(vc: NewsViewController(), titleName: "News", imageName: "newspaper")
        let selectedNewsViewController = createNavigationController(vc: SelectedNewsViewController(), titleName: "Selected News", imageName: "star")
        viewControllers = [newsViewController, selectedNewsViewController]
    }
    
    func createNavigationController(vc: UIViewController, titleName: String, imageName: String) -> UINavigationController{
        let item = UITabBarItem(title: titleName,
                                image: UIImage(systemName: imageName)?.withAlignmentRectInsets(.init(top: 10,
                                                                                                     left: 0,
                                                                                                     bottom: 0,
                                                                                                     right: 0)),
                                tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        return navController
    }

}
