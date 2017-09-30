//
//  Fonts.swift
//  test
//
//  Created by air on 23.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

//struct which contains static properties of colors and fonts used in app

struct Style{
    
    private static let fontSize:CGFloat = 12.0
    private static let mainFontName = "Avenir-Book"
    private static let boldFontName = "Avenir-Heavy"
    
    static var startGradientColor:UIColor{
        get{
            return UIColor(hex:"304075")
        }
    }
    static var endGradientColor:UIColor{
        get{
            return UIColor(hex:"6c7baa")
        }
    }
    static var mainColor:UIColor{
        get{
            return UIColor(hex: "364563")
        }
    }
    static var mainFont:UIFont{
        get{
            return UIFont(name: mainFontName, size: fontSize)!
        }
    }
    static var mainFontBold:UIFont{
        get{
            return UIFont(name: boldFontName, size: fontSize)!
        }
    }
}
