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
        
        homeViewController.tabBarItem.image = UIImage.init(systemName: "house.fill")
        mealViewController.tabBarItem.image = UIImage.init(systemName: "fork.knife")
        bulletinBoardViewController.tabBarItem.image = UIImage.init(systemName: "list.bullet.rectangle.portrait.fill")
        myPageViewController.tabBarItem.image = UIImage.init(systemName: "person.crop.circle.fill")
    
        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationMeal = UINavigationController(rootViewController: mealViewController)
        let navigationBulletinBoard = UINavigationController(rootViewController: bulletinBoardViewController)
        let navigationMyPageViewController = UINavigationController(rootViewController: myPageViewController)
      
        setViewControllers([navigationHome, navigationMeal, navigationBulletinBoard, navigationMyPageViewController], animated: false)
    }
}

