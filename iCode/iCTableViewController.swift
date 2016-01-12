//
//  iCTableViewController.swift
//  CLF
//
//  Created by Mohamed Shafraz on 04/12/2014.
//  Copyright (c) 2014 Child Labor Free Holdings Ltd. All rights reserved.
//

import UIKit

struct TableCellType {
    static let LongTextCell = "LongTextCell"
    static let ShortTextCell = "ShortTextCell"
    static let SwitchCell = "SwitchCell"
    static let NomalCell = "NomalCell"
}

class iCTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tableView:UITableView?
    
    func setup(){
        setup(UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    }
    
    func setup(frame: CGRect, style: UITableViewStyle) {
        if tableView == nil {
            tableView = UITableView(frame: frame, style: style)
            tableView?.scrollsToTop = true
            tableView?.delegate = self
            tableView?.dataSource = self
            self.view.addSubview(tableView!)
            
            tableView?.registerNib(UINib(nibName: "LongTextTableCell", bundle: nil), forCellReuseIdentifier: TableCellType.LongTextCell)
            tableView?.registerNib(UINib(nibName: "ShortTextTableCell", bundle: nil), forCellReuseIdentifier: TableCellType.ShortTextCell)
            tableView?.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: TableCellType.SwitchCell)
            tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: TableCellType.NomalCell)
            
        }
    }
    
    func layout() {
        var tableViewFrame = UIScreen.mainScreen().bounds

        if !UIApplication.sharedApplication().statusBarHidden {
            tableViewFrame.size.height -= 20.0 //UIApplication.sharedApplication().statusBarFrame.height
            tableViewFrame.origin.y += 20.0 //UIApplication.sharedApplication().statusBarFrame.height
        }
        
        if (self.navigationController?.navigationBarHidden != nil) {
            tableViewFrame.size.height -= self.navigationController!.navigationBar.frame.size.height
            tableViewFrame.origin.y += self.navigationController!.navigationBar.frame.size.height
        }
        
        if (self.tabBarController?.tabBar.hidden != nil) {
            tableViewFrame.size.height -= self.tabBarController!.tabBar.frame.height
        }
        
        tableView?.frame = tableViewFrame
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func heightOfVisibleView() ->CGFloat {
        var height = UIScreen.mainScreen().bounds.size.height
        
        if !UIApplication.sharedApplication().statusBarHidden {
            height -= 20
        }
        
        if (self.navigationController?.navigationBarHidden != nil) {
            height -= self.navigationController!.navigationBar.frame.size.height
        }
        
        if (self.tabBarController?.tabBar.hidden != nil) {
            height -= self.tabBarController!.tabBar.frame.height
        }
        
        return height
    }
    
    func resetTableViwe() {
        layout()
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    convenience init(frame: CGRect, style: UITableViewStyle) {
        self.init()
        setup(frame, style: style)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
        var cell:UITableViewCell? = tableView?.dequeueReusableCellWithIdentifier(reuseIdentifier) 
        //tableView?.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        }
        return cell!
    }
    
    func tableView(_tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
