//
//  SearchViewController.swift
//  blog
//
//  Created by Leo on 3/1/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import Foundation
import UIKit
class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var search: UISearchBar!
    
    let passgeListURL = Global.server + Global.passageListURL
    
    var passages = [Passage]()
    var currentPage = 0
    var totalPage = 0
    var query:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        search.delegate = self
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        query = search.text
        loadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "passageCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SearchTableViewCell
        let passage = passages[indexPath.row]
        cell.title.text = passage.title!
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let detail = segue.destinationViewController as! DetailViewController
            if let selectedPassageCell = sender as? SearchTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedPassageCell)
                let selectedPassage = self.passages[indexPath!.row]
                detail.passage = selectedPassage
            }
        }
    }
    
    func loadData() {
        if query == nil || query!.trim() == "" {
            return
        }
        
        let page = getPage()
        let session = NSURLSession.sharedSession()
        let urlStr = "\(passgeListURL)?page=\(page)&query=\(query!.encodeChinese())"
        let url = NSURL(string: urlStr)
        
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
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && currentPage < totalPage) {
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
