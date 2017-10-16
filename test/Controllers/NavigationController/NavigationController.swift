//
//  NavigationController.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        let coreDataManager = CoreDataManager()
        if coreDataManager.loginedAlreadyUserExists(){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mpvc = storyBoard.instantiateViewController(withIdentifier: String(describing: MessagesAndPostsViewController.self)) as! MessagesAndPostsViewController
            mpvc.coreDataManager = coreDataManager
            self.show(mpvc, sender: self)
        }else{
            let tbc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            (tbc.viewControllers![0] as! LoginViewViewController).coreDataManager = coreDataManager
            (tbc.viewControllers![1] as! SignupViewController).coreDataManager = coreDataManager
            self.show(tbc,sender: self)
        }
    }
}
