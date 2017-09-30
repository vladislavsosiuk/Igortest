//
//  NetworkManager.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class NetworkManager{
    static func getArrayFromRequest<T:BaseMappable>(url: String, completionHandler: @escaping (DataResponse<[T]>)->()){
        
        Alamofire.request(url).responseArray(completionHandler: completionHandler)
    }
}
