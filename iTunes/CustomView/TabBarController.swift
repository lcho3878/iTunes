//
//  TabBarController.swift
//  iTunes
//
//  Created by 이찬호 on 8/8/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchVC = SearchViewController()
        searchVC.title = "검색"
        let searchNaVC = UINavigationController(rootViewController: searchVC)
        searchNaVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        setViewControllers([searchNaVC], animated: true)
    }
    
}
