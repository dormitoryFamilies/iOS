//
//  TabbarViewController.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2023/09/21.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .white

        let homeViewController = HomeViewController()
        let mealViewController = MealViewController()
        let bulletinBoardViewController = BulletinBoardViewController()
        let myPageViewController = MyPageViewController()
        
        
        homeViewController.title = "홈"
        mealViewController.title = "식단"
        bulletinBoardViewController.title = "게시판"
        myPageViewController.title = "마이페이지"
        
        homeViewController.tabBarItem.image = UIImage.init(systemName: "house")
        mealViewController.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
        bulletinBoardViewController.tabBarItem.image = UIImage.init(systemName: "book")
        myPageViewController.tabBarItem.image = UIImage.init(systemName: "book")
    
        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationMeal = UINavigationController(rootViewController: mealViewController)
        let navigationBulletinBoard = UINavigationController(rootViewController: bulletinBoardViewController)
        let navigationMyPageViewController = UINavigationController(rootViewController: myPageViewController)
      
        setViewControllers([navigationHome, navigationMeal, navigationBulletinBoard, navigationMyPageViewController], animated: false)
    }
}

