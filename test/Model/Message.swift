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
    static func loadSampleMessages()->[Message]{
        //        let image1="defaultImage"
        //         let image2="defaultImage"
        //        let image3="defaultImage"
        let image1="https://image.freepik.com/free-photo/horizon-texture-aged-scene-//weather_1088-693.jpg"
        let image2="https://i.pinimg.com/736x/3f/a7/dd/3fa7dd9f821cd3d0c06c6568a15bf14d--forest-engagement-photos-engagement-pics.jpg"
        let image3="https://i.pinimg.com/736x/11/c8/49/11c849dd69eb68a21a170ffc524e5bbd--country-fences--beds.jpg"
        let message1 = Message(name: "Eva Hernandez", text: "sent you 24$ in your account",image: image1, date: Date.createDate(day:1, month: 7, year: 2012))
        
        //
        let message2 = Message(name: "Raymond Alvaro", text: "commented on your post",image: image2, date: Date.createDate(day:1, month: 7, year: 2013))
        
        //        let image3="https://i.pinimg.com/736x/11/c8/49/11c849dd69eb68a21a170ffc524e5bbd--country-fences--beds.jpg"
        let message3 = Message(name: "Kris m williams", text: "sent you 24$ in your account",image: image3, date: Date.createDate(day:1, month: 7, year: 2014))
        
        return [message1,message2,message3 ]
    }
    static func loadSampleMessages2()->[Message]{
        //        let image1="defaultImage"
        //        let image2="defaultImage"
        //        let image3="defaultImage"
        let image1="https://pixabay.com/p-1958841/"
        let image2="https://pixlr.com/assets/images/landing/gallery/5.jpg?1502172435"
        let image3="https://lh4.googleusercontent.com/-OowXWkgMSHI/AAAAAAAAAAI/AAAAAAAAANE/rOf2DCA2AXo/photo.jpg"
        let message1 = Message(name: "Eva Hernandez2", text: "sent you 24$ in your account",image: image1, date: Date.createDate(day:1, month: 7, year: 2016))
        let message2 = Message(name: "Raymond Alvaro2", text: "commented on your post",image: image2, date: Date.createDate(day:1, month: 7, year: 2017))
        let message3 = Message(name: "Kris m williams2", text: "sent you 24$ in your account",image: image3, date: Date.createDate(day:1, month: 7, year: 2018))
        
        return[message1,message2,message3 ]
        
    }
    static func loadSampleMessages3()->[Message]{
        //          let image1="defaultImage"
        //        let image2="defaultImage"
        //        let image3="defaultImage"
        let image1="https://www.odt.co.nz/sites/default/files/styles/odt_story_slideshow/public/slideshow/node-1245328/2017/05/mike_wilkinson_0.jpg?itok=696xZmVu"
        let image2="https://images.pexels.com/photos/227674/pexels-photo-227674.jpeg?h=350&auto=compress&cs=tinysrgb"
        let image3="https://www.lunapic.com/editor/images/slide22.jpg"
        let message1 = Message(name: "Eva Hernandez3", text: "sent you 24$ in your account",image: image1, date: Date.createDate(day:1, month: 7, year: 2019))
        let message2 = Message(name: "Raymond Alvaro3", text: "commented on your post",image: image2
            , date: Date.createDate(day:1, month: 7, year: 2020))
        let message3 = Message(name: "Kris m williams3", text: "sent you 24$ in your account",image: image3, date: Date.createDate(day:1, month: 7, year: 2021))
        
        return[message1,message2,message3]
    }
}
