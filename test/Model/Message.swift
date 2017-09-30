//
//  Message.swift
//  test
//
//  Created by air on 19.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation

class Message{
    var name:String
    var text:String
    var image:String
    var date:Date
    init(name:String, text:String, image:String, date:Date){
        self.name=name
        self.text = text
        self.image = image
        self.date = date
    }
}
