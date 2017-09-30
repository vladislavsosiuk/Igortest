//
//  TableViewCell.swift
//  test
//
//  Created by air on 29.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static var Identifier:String{
        get{
            return "PostCell"
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    func makeCell(fromPost post: Post){
        
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
    
}
