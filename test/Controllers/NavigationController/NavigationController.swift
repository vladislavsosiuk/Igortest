//
//  NavigationController.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataManager = CoreDataManager()
//        if true{
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let mpvc = storyBoard.instantiateViewController(withIdentifier: String(describing: MessagesAndPostsViewController.self)) as! MessagesAndPostsViewController
//            self.navigationController?.show(mpvc, sender: nil)
//        }else{
//            let lvc = self.storyboard!.instantiateViewController(withIdentifier: String(describing:LoginViewViewController.self)) as! LoginViewViewController
//            self.navigationController?.show(lvc,sender: nil)
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
