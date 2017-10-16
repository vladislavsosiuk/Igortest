//
//  LoginViewViewController.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class LoginViewViewController: UIViewController {
    var coreDataManager:CoreDataManager?

    @IBOutlet weak var emailTextField: UITextField!
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        if (emailTextField.text == nil || passwordTextField.text == nil){
            showAlert(message: "Check email or password")
            return
        }
        if !emailIsValid(){
            showAlert(message: "Email is not valid")
            return
        }
        if !passwordIsValid(){
            showAlert(message: "Password is not valid")
            return
        }
        
        let logined = self.coreDataManager?.findUserByEmailAndPassword(email: emailTextField.text!, password: passwordTextField.text!)
        if logined != nil && logined!{
            let pmvc = self.storyboard!.instantiateViewController(withIdentifier: String(describing: MessagesAndPostsViewController.self)) as! MessagesAndPostsViewController
            pmvc.coreDataManager=self.coreDataManager
            self.navigationController?.show(pmvc, sender: self)
        }else{
            self.showAlert(message: "User not found")
        }
    }
   
    func emailIsValid()->Bool{
        guard let unwrText = emailTextField.text else {
            return false
        }
        return String.isValidEmail(unwrText)
    }
    func passwordIsValid()->Bool{
        guard let unwrText = passwordTextField.text else {
            return false
        }
        return unwrText.count>5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden=true
     
    }

}
