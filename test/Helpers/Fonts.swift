//
//  Fonts.swift
//  test
//
//  Created by air on 23.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

let fontSize:CGFloat = 12.0
let mainFontName = "Avenir-Book"
let boldFontName = "Avenir-Heavy"
class MyFonts{
    
    static func mainFont()->UIFont{
        return UIFont(name: mainFontName, size: fontSize)!
    }
    static func mainFontBold()->UIFont{
        return UIFont(name: boldFontName, size: fontSize)!
    }
}
