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





enum SegmentedButtons:Int{
    case mentions=0, myStudents, myTuDrs
    
}

class MessagesAndPostsViewController: UIViewController, ContainsPosts{
    
    var activityIndicator:UIActivityIndicatorView? = nil
    
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
                activityIndicator?.stopAnimating()
                posts = nil
                messages = APIManager.getMessages(parameter: selectedButton.rawValue)
            case .myStudents:
                messages = nil
                activityIndicator?.startAnimating()
                APIManager.getPosts(callBack: {
                    result in
                    self.activityIndicator?.stopAnimating()
                    if self.selectedButton == .myStudents{
                        self.posts = result
                    }
                })
            case .myTuDrs:
                activityIndicator?.stopAnimating()
                posts = nil
                messages = APIManager.getMessages(parameter: selectedButton.rawValue)
        }
        
    }
    func setActivityIndicator()->UIActivityIndicatorView{
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        ai.center = self.view.center
        self.view.addSubview(ai)
        return ai
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
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator = setActivityIndicator()
    }
    
    func setNavIcons(){
        let logo = #imageLiteral(resourceName: "navLogo")
        let imageView = UIImageView(image:logo)
        //sets middle navigationbar icon
        self.navigationItem.titleView = imageView
        //sets left navigationbar button
        self.navigationItem.setLeftBarButton(makeBarButtonItem(withImage:#imageLiteral(resourceName: "defaultImage"), contentMode: .scaleAspectFit), animated: true)
        //sets right navigationbar button
        self.navigationItem.setRightBarButton(makeBarButtonItem(withImage: #imageLiteral(resourceName: "gearIcon"), contentMode:.center, action: #selector(signOut)), animated: true)
    }
    func signOut(sender: AnyObject?){
        let coreDataManager = CoreDataManager()
        coreDataManager.signOutUser()
        let tbc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarController")
        self.navigationController?.show(tbc, sender: self)
    }
    //creates UIBarButtonItem from UIImage
    func makeBarButtonItem(withImage image:UIImage, contentMode:UIViewContentMode = .scaleAspectFill, action: Selector? = nil)->UIBarButtonItem{
        let navButton = UIButton(frame: CGRect(x:0,y:0,width: Style.navItemWidthAndHeight,height: Style.navItemWidthAndHeight))
        if let action = action{
            navButton.addTarget(self, action: action, for: .touchUpInside)
        }
        navButton.setImage(image, for: .normal)
        navButton.imageView?.contentMode = contentMode
        navButton.imageView?.frame = navButton.frame
        navButton.cornerRadius = Style.navItemCornerRadius
        navButton.clipsToBounds = true
        let item = UIBarButtonItem(customView: navButton)
        return item
    }
    
    

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if messages == nil{
            return
        }
        let vcfcv = self.storyboard!.instantiateViewController(withIdentifier: ViewControllerForCollectionView.identifier) as! ViewControllerForCollectionView
        vcfcv.messages = self.messages!
        self.navigationController?.show(vcfcv, sender: self)
        
    }
}

