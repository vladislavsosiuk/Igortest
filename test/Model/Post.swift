//
//  Post.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
import ObjectMapper


public class Post: Mappable{
    var userId:Int?
    var id:Int?
    var title:String?
    var body:String?
    
    init(userId: Int, id:Int, title: String, body:String){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    
    }
    
    required public init?(map: Map) {
        
    }
    public func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}
