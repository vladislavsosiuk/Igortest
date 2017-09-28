//
//  GeneralExtensions.swift
//  test
//
//  Created by air on 21.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
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
