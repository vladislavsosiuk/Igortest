//
//  ThreeCollectionViewCell.swift
//  test
//
//  Created by air on 07.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

class ThreeCollectionViewCell: UICollectionViewCell {
    public static let identifier = "collectionCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    func makeCell(message: Message){
        self.image.af_setImage(withURL: URL(string: message.image)!)
        self.label.text = message.text
        self.label.font = Style.mainFont
        self.label.textColor=Style.mainColor
    }
}
