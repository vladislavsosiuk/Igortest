//
//  PostsManager.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CoreData

typealias DataCallback<T> = (_ data:T)->()

class APIManager{
    
    
    
    static func getPosts(callBack:@escaping DataCallback<[Post]>){
        let coreDataManager = CoreDataManager()
        if coreDataManager.containsPosts(){
            let posts = coreDataManager.getPostsFromCore()
            if let unwrPost = posts {
                if unwrPost.count>0{
                    callBack(unwrPost)                    
                    return
                }
            }
        }
        
        let url = "https://jsonplaceholder.typicode.com/posts/"
        
        NetworkManager.getArrayFromRequest(url: url, completionHandler: {(response: DataResponse<[Post]>) in
            
            coreDataManager.setPostsToCore(posts: response.result.value)
            callBack(response.result.value!)
        })
    }
    static func getMessages(parameter: Int)->[Message]?{
        switch parameter{
        case 0:
            let image1="https://image.freepik.com/free-photo/horizon-texture-aged-scene-//weather_1088-693.jpg"
            let image2="https://i.pinimg.com/736x/3f/a7/dd/3fa7dd9f821cd3d0c06c6568a15bf14d--forest-engagement-photos-engagement-pics.jpg"
            let image3="https://i.pinimg.com/736x/11/c8/49/11c849dd69eb68a21a170ffc524e5bbd--country-fences--beds.jpg"
            let message1 = Message(name: "Eva Hernandez", text: "sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account sent you 24$ in your account ",image: image1, date: Date.createDate(day:1, month: 7, year: 2012))
            
            //
            let message2 = Message(name: "Raymond Alvaro", text: "commented on your post",image: image2, date: Date.createDate(day:1, month: 7, year: 2013))
            
            //        let image3="https://i.pinimg.com/736x/11/c8/49/11c849dd69eb68a21a170ffc524e5bbd--country-fences--beds.jpg"
            let message3 = Message(name: "Kris m williams", text: "sent you 24$ in your account",image: image3, date: Date.createDate(day:1, month: 7, year: 2014))
            
            return [message1,message2,message3 ]
        case 2:
            let image1="https://www.odt.co.nz/sites/default/files/styles/odt_story_slideshow/public/slideshow/node-1245328/2017/05/mike_wilkinson_0.jpg?itok=696xZmVu"
            let image2="https://images.pexels.com/photos/227674/pexels-photo-227674.jpeg?h=350&auto=compress&cs=tinysrgb"
            let image3="https://www.lunapic.com/editor/images/slide22.jpg"
            let message1 = Message(name: "Eva Hernandez3", text: "sent you 24$ in your account",image: image1, date: Date.createDate(day:1, month: 7, year: 2019))
            let message2 = Message(name: "Raymond Alvaro3", text: "commented on your post",image: image2
                , date: Date.createDate(day:1, month: 7, year: 2020))
            let message3 = Message(name: "Kris m williams3", text: "sent you 24$ in your account",image: image3, date: Date.createDate(day:1, month: 7, year: 2021))
            
            return[message1,message2,message3]
        default:
            return nil
        }
    }
}
