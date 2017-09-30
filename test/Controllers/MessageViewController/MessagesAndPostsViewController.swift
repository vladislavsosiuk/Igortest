//
//  ViewController.swift
//  test
//
//  Created by air on 19.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import UIKit

protocol ContainsPosts {
    func setPosts(posts: [Post]?)
    
}


extension MessagesAndPostsViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let unwrPosts = posts{
            return unwrPosts.count
        }else if let unwrMessages = messages{
            return unwrMessages.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let unwrPosts = posts {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.Identifier, for: indexPath) as! PostTableViewCell
            
            
            let post = unwrPosts[indexPath.row]
            cell.makeCell(fromPost: post)
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.Identifier, for: indexPath) as! MessageTableViewCell
            
            
            let message = messages![indexPath.row]
            cell.makeCell(fromMessage: message)
            
            return cell
        }
        
        
        
    }
}


enum SegmentedButtons:Int{
    case mentions=0, myStudents, myTuDrs
    
}

class MessagesAndPostsViewController: UIViewController, ContainsPosts{
    
    var messages :[Message]?{
        didSet{
            tableView.reloadData()
        }
    }
    var posts:[Post]?{
        didSet{
            tableView.reloadData()
        }
    }
    //conforms protocol ContainsPosts
    func setPosts(posts: [Post]?) {
        self.posts = posts
    }
    
    required init?(coder: NSCoder){
        
        messages = nil
        posts = nil
        super.init(coder: coder)
    }
    var selectedButton:SegmentedButtons = .mentions
    
    @IBOutlet weak var mentioned: UIButton!
    @IBOutlet weak var myStudents: UIButton!
    @IBOutlet weak var myTuDrs: UIButton!
    
    @IBAction func segmentedButtonClicked(_ sender: UIButton) {
        
        setDefaultStateToLastButton()
        updateSelectedButtonAndSetSelectedState(button: sender)
        updateData(selectedButton)
    }
    func setDefaultStateToLastButton(){
        switch selectedButton{
        case .mentions:
            mentioned.titleLabel?.font = Style.mainFont
        case .myStudents:
            myStudents.titleLabel?.font = Style.mainFont
        case .myTuDrs:
            myTuDrs.titleLabel?.font = Style.mainFont
        }
    }
    func updateSelectedButtonAndSetSelectedState(button: UIButton){
        switch button {
        case mentioned:
            selectedButton = .mentions
        case myStudents:
            selectedButton = .myStudents
        case myTuDrs:
            selectedButton = .myTuDrs
        default:
            ()
        }
        button.titleLabel?.font = Style.mainFontBold
    }
    
    func updateData(_ dataType: SegmentedButtons){
        
        switch(dataType){
            case .mentions:
                posts = nil
                messages = APIManager.getMessages(parameter: selectedButton.rawValue)
            case .myStudents:
                messages = nil
                APIManager.getPosts(callBack: {
                    result in
                    self.posts = result
                })
            case .myTuDrs:
                posts = nil
                messages = APIManager.getMessages(parameter: selectedButton.rawValue)
        }
        
    }
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden=false
        
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: PostTableViewCell.Identifier)
        
        messages = APIManager.getMessages(parameter: selectedButton.rawValue)
    }
    override func viewDidLayoutSubviews() {
        //set gradient background to navigation bar
        self.navigationController?.navigationBar.setGradientBackground(colors: [Style.startGradientColor, Style.endGradientColor])
        
        setNavIcons()
        
        //removes last separator
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        
        //sets tableviewcell to fit its content
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
    }
    
    func setNavIcons(){
        let logo = #imageLiteral(resourceName: "navLogo")
        let imageView = UIImageView(image:logo)
        //sets middle navigationbar icon
        self.navigationItem.titleView = imageView
        //sets left navigationbar button
        self.navigationItem.setLeftBarButton(makeBarButtonItem(withImage:#imageLiteral(resourceName: "defaultImage")), animated: true)
        //sets right navigationbar button
        self.navigationItem.setRightBarButton(makeBarButtonItem(withImage: #imageLiteral(resourceName: "gearIcon"), contentMode:.center), animated: true)
    }
    //creates UIBarButtonItem from UIImage
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
    
    

}

