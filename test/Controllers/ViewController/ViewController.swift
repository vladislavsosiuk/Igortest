//
//  ViewController.swift
//  test
//
//  Created by air on 19.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages = [Message]()
    
    
    
    @IBOutlet weak var mentions: UIButton!
    @IBOutlet weak var myTuDrs: UIButton!
    @IBOutlet weak var myStudents: UIButton!
    
    func  getButtons()->[UIButton]{
       return [mentions, myStudents, myTuDrs]
    }
    
    var selectedButton:SegmentedButtons = .mentions
    
    @IBAction func mentionsButtonClicked(_ sender: Any) {
        selectedButton = .mentions
        updateButtons()
        updateData(selectedButton)
    }
    @IBAction func myStudentsButtonClicked(_ sender: Any) {
        selectedButton = .myStudents
        updateButtons()
        updateData(selectedButton)
    }
    @IBAction func myTuDrsButtonClicked(_ sender: Any) {
        selectedButton = .myTuDrs
        updateButtons()
        updateData(selectedButton)
    }
    func updateButtons(){
        let buttons = getButtons()
        for button in buttons{
            button.titleLabel?.font = MyFonts.mainFont()
        }
        switch(selectedButton){
        case .mentions:
            mentions.titleLabel?.font = MyFonts.mainFontBold()
        case .myStudents:
            myStudents.titleLabel?.font = MyFonts.mainFontBold()
        case .myTuDrs:
            myTuDrs.titleLabel?.font = MyFonts.mainFontBold()
        }
    }
    func updateData(_ dataType: SegmentedButtons){
        
        switch(dataType){
            case .mentions:
                messages=Message.loadSampleMessages()
            case .myStudents:
                messages=Message.loadSampleMessages2()
            case .myTuDrs:
                messages=Message.loadSampleMessages3()
        }
        self.tableView.reloadData()
    }
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavIcons()
        messages = Message.loadSampleMessages()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    func setNavIcons(){
        let logo = #imageLiteral(resourceName: "navLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationItem.setLeftBarButton(makeBarButtonItem(withImage:#imageLiteral(resourceName: "defaultImage")), animated: true)
        self.navigationItem.setRightBarButton(makeBarButtonItem(withImage: #imageLiteral(resourceName: "gearIcon"), contentMode:.center), animated: true)
    }
    func makeBarButtonItem(withImage image:UIImage, contentMode:UIViewContentMode = .scaleAspectFill)->UIBarButtonItem{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.contentMode = contentMode
        view.addSubview(imageView)
        view.cornerRadius=20
        view.clipsToBounds = true
        let item = UIBarButtonItem(customView: view)
        return item
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MessageTableViewCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessageTableViewCell


        let message = messages[indexPath.row]
        cell.makeCell(fromMessage: message)

        return cell
    }

}

