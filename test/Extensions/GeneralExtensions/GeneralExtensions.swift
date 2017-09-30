//
//  GeneralExtensions.swift
//  test
//
//  Created by air on 21.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
//method that created Date object from day, month and year
extension Date{
    static func createDate (day: Int, month: Int, year: Int)->Date{
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        let date = Calendar.current.date(from: components)
        return date!
    }
}
extension String{
    static func isValidEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
