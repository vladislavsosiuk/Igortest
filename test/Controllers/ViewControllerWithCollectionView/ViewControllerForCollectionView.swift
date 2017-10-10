//
//  ViewControllerForCollectionView.swift
//  test
//
//  Created by air on 07.10.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

enum columnButtons{
    case threeColumns
    case twoColumns
    case oneColumn
}

extension ViewControllerForCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
}

class ViewControllerForCollectionView: UIViewController {
    
    
    var selectedButton:columnButtons = .threeColumns
    var posts = [Post]()

    @IBOutlet weak var threeColumnsButton: UIButton!
    @IBOutlet weak var twoColumnsButton: UIButton!
    @IBOutlet weak var oneColumnButton: UIButton!
    
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
        default:()
        
            
        }
    }
    func updateCollectionView(_ button: UIButton){
//        switch button {
//        case threeColumnsButton:
//            
//        default:
//            <#code#>
//        }
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
    
    static let identifier = "ViewControllerForCollectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
