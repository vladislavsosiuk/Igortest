//
//  LoginViewViewController.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class LoginViewViewController: UIViewController {

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
        var coreDateManager = CoreDataManager()
        let logined = coreDateManager.login(email: emailTextField.text!, password: passwordTextField.text!)
        if logined{
        let pmvc = self.storyboard!.instantiateViewController(withIdentifier: String(describing: MessagesAndPostsViewController.self))
        self.navigationController?.show(pmvc, sender: self)
        }else{
            self.showAlert(message: "User not found")
        }
    }
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        var signVC = self.storyboard!.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as! SignupViewController
        self.navigationController?.show(signVC, sender: self)
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
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}