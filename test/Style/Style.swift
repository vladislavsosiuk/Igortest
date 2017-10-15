//
//  Fonts.swift
//  test
//
//  Created by air on 23.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

//struct which contains static properties of colors and fonts used in app

enum Style{
    
    private static let fontSize:CGFloat = 12.0
    private static let mainFontName = "Avenir-Book"
    private static let boldFontName = "Avenir-Heavy"
    
    static let startGradientColor = UIColor(hex:"304075")
    static let endGradientColor = UIColor(hex:"6c7baa")
    static let mainColor = UIColor(hex: "364563")
    static let mainFont = UIFont(name: mainFontName, size: fontSize)!
    static let mainFontBold = UIFont(name: boldFontName, size: fontSize)!
    static let navItemWidthAndHeight = 40
    static let navItemCornerRadius = CGFloat(20)
}
