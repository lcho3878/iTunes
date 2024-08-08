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
        let searchVC = ViewController()
        searchVC.title = "서치"
        let aVC = ViewController()
        aVC.title = "임시"
        setViewControllers([searchVC, aVC], animated: true)
    }
    
}
