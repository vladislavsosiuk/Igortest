//
//  SignupViewController.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    var coreDataManager:CoreDataManager?

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        if !emailIsValid(){
            self.showAlert(message: "Check email")
            return
        }
        if !passwordIsValid(){
            self.showAlert(message: "Check password")
            return
        }
        if !passwordsAreSame(){
            self.showAlert(message: "Passwords are not same")
            return
        }
        if !olderThan18(){
            self.showAlert(message: "You are too young")
            return
        }
        self.coreDataManager?.registerNewUser(email: emailInput.text!, password: passwordInput.text!,birthday:  birthdayDatePicker.date)
        
        let mpvc = self.storyboard!.instantiateViewController(withIdentifier: String(describing: MessagesAndPostsViewController.self)) as! MessagesAndPostsViewController
        mpvc.coreDataManager = coreDataManager
        self.navigationController?.show(mpvc, sender: self)
    }
    func emailIsValid()->Bool{
        guard let unwrText = emailInput.text else {
            return false
        }
        return String.isValidEmail(unwrText)
    
    }
    func passwordIsValid()->Bool{
        guard let unwrText = passwordInput.text else {
            return false
        }
        return unwrText.count>5
    }
    func passwordsAreSame()->Bool{
        guard let firstPassword = passwordInput.text else {
            return false
        }
        guard let secondPassword = confirmPasswordInput.text else{
            return false
        }
        return firstPassword == secondPassword
    }
    func olderThan18()->Bool{
       return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nowDate = Date()
        let maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: nowDate)
        birthdayDatePicker.maximumDate = maximumDate
    }

    

}
