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
    
    @IBOutlet var scroll: UIScrollView!
//    let customDomain = "https://www.huzhonghua.cn"
    let passgeListURL = "http://192.168.133.1:9000/showPassagesToJSON"
    let passageDetailURL = "http://192.168.133.1:9000/passage"
    
    var passages = [Passage]()
    var currentPage = 0
    var totalPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scroll.delegate = self
      
        // register refresh control
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Drag to refresh.")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        // load data from server
        loadData()
    }
    
    func reload() {
        self.refreshControl?.beginRefreshing()
        loadData(true)
        self.refreshControl?.endRefreshing()
    }

    func loadData(isRefresh:Bool = false) {
        var page = 1
        
        if (isRefresh) {
            self.passages = [Passage]()
        } else {
            page = getPage()
        }
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: passgeListURL + "?page=\(page)")
        NSLog("Requesting \(url)")
        
        session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                NSLog(error!.localizedDescription)
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:[])
                let currentPage = json["currentPage"] as! Int
                let totalPage = json["totalPage"] as! Int
                self.currentPage = currentPage
                self.totalPage = totalPage
                
                if let passagesJson = json["passages"] as? [[String: AnyObject]] {
                    for p in passagesJson {
                        let id = p["id"] as! Int
                        let authorId = p["authorId"] as! Int
                        let authorName = p["authorName"] as! String
                        let title = p["title"] as! String
                        let content = p["content"] as! String
                        
                        let formatter = NSDateFormatter()
                        formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
                        let createTime = formatter.stringFromDate(NSDate(timeIntervalSince1970: p["createTime"] as! NSTimeInterval / 1000))
                        
                        let viewCount = p["viewCount"] as! Int
                        let passage = Passage(id: id,authorId: authorId, authorName: authorName, title: title, content: content,createTime: createTime, viewCount: viewCount)

                        self.passages += [passage]
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            catch {
                NSLog("Get passage list with error: \(error)")
            }
        }).resume()
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
        cell.postDetail.text = "Posted by \(passage.authorName) at \(passage.createTime)"
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height + 50 && currentPage < totalPage) {
            loadData()
        }
    }
    
    private func getPage() -> Int{
        if currentPage <= 0 {
            return 1
        } else if currentPage < totalPage {
            return currentPage + 1
        } else {
            return totalPage
        }
    }
}
