//
//  ViewControllerForCollectionView.swift
//  test
//
//  Created by air on 07.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

enum columnButtons:Int{
    case threeColumns=3
    case twoColumns=2
    case oneColumn=1
}



class ViewControllerForCollectionView: UIViewController {
    static let identifier = "ViewControllerForCollectionView"
    
    var selectedButton:columnButtons = .threeColumns
    var messages = [Message]()
    

    @IBOutlet weak var threeColumnsButton: UIButton!
    @IBOutlet weak var twoColumnsButton: UIButton!
    @IBOutlet weak var oneColumnButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func segmentedButtonTapped(_ sender: UIButton) {
        deselectCurrentButton()
        changeSelectedButton(sender)
        sender.titleLabel?.font = Style.mainFontBold
        updateCollectionView(sender)
    }
    func changeSelectedButton(_ button: UIButton){
        switch button {
        case threeColumnsButton:
            selectedButton = .threeColumns
        case twoColumnsButton:
            selectedButton = .twoColumns
        case oneColumnButton:
            selectedButton = .oneColumn
        default:()
        
            
        }
    }
    func updateCollectionView(_ button: UIButton){
        collectionView.reloadData()
    }
    func deselectCurrentButton(){
        
        var oldButton:UIButton?
        switch selectedButton {
        case .threeColumns:
            oldButton = threeColumnsButton
        case .twoColumns:
            oldButton = twoColumnsButton
        case .oneColumn:
            oldButton = oneColumnButton
        }
        oldButton?.titleLabel?.font = Style.mainFont
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    

}
extension ViewControllerForCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeCollectionViewCell.identifier, for: indexPath) as! ThreeCollectionViewCell
        
        cell.makeCell(message: messages[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 10
        let width = collectionView.frame.width/CGFloat(selectedButton.rawValue)-CGFloat(inset)
        
        return CGSize(width:width, height: width)
    }
}
