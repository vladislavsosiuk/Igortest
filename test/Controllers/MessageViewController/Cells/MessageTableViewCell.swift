//
//  MessageTableViewCell.swift
//  test
//
//  Created by air on 19.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MessageTableViewCell: UITableViewCell {
    
    static var Identifier:String{
        get{
            return "MessageTableViewCell"
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imagee: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func makeCell(fromMessage message:Message){
        
        let attributtedString = NSMutableAttributedString()
        
        attributtedString.append(NSAttributedString(attributedString: NSAttributedString(string: message.name+" ", attributes: [NSFontAttributeName: Style.mainFont])))
        attributtedString.append(NSAttributedString(attributedString: NSAttributedString(string: message.text, attributes: [NSFontAttributeName: Style.mainFont])))
        
        self.nameLabel.attributedText=attributtedString
        self.nameLabel.textColor=Style.mainColor
        
        let url = URL(string: message.image)
        if(message.image != "defaultImage"){
            self.imagee.downloadFromUrl(url: url!)
        }else{
            self.imagee.image = #imageLiteral(resourceName: "defaultImage")
        }
        
        self.imagee.layer.cornerRadius = self.imagee.frame.width/2
        self.imagee.layer.masksToBounds=true
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.date.text = dateFormatter.string(from: message.date)
        self.date.font = Style.mainFont
        self.date.textColor = Style.mainColor
    }
}
