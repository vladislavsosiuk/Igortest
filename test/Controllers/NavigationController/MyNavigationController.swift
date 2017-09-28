//
//  MyNavigationController.swift
//  test
//
//  Created by air on 20.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit
class MyNavigationController:UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setGradientBackground(colors: [MyColors.startGradientColor(), MyColors.endGradientColor()])
        
    }
    
    
}
