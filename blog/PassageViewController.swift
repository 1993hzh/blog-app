//
//  PassageView.swift
//  blog
//
//  Created by Leo on 2/21/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import Foundation
import UIKit

class PassageViewController: UITableViewController {
    
    let passgeListURL = "https://www.huzhonghua.cn/showPassagesToJSON"
    let passageDetailURL = "https://www.huzhonghua.cn/passage"
    
    var passages = [Passage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.registerClass(PassageTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // register refresh control
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Drop to refresh.")
        refresh.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        // load data from server
        //loadData()
        let p1 = Passage(id: 1,authorId: 1,authorName: "123",title: "1", content: "1",createTime: "",viewCount: 0)
        let p2 = Passage(id: 1,authorId: 1,authorName: "123",title: "2", content: "2",createTime: "",viewCount: 0)
        let p3 = Passage(id: 1,authorId: 1,authorName: "123",title: "3", content: "3",createTime: "",viewCount: 0)
        passages += [p1,p2,p3]
    }

    func loadData() {
        self.refreshControl?.beginRefreshing()
        let session = NSURLSession.sharedSession()
        let url = NSURL(fileURLWithPath: passgeListURL)
        
        session.dataTaskWithURL(url, completionHandler: {response, data, error -> Void in
            if (error != nil) {
                NSLog(error!.localizedDescription)
            } else {
                
            }
        })
        
        self.refreshControl?.endRefreshing()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PassageTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PassageTableViewCell
        let passage = passages[indexPath.row]
        cell.content.text = passage.content
        cell.title.text = passage.title
        return cell
    }
}
