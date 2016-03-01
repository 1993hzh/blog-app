//
//  Passage.swift
//  blog
//
//  Created by Leo on 2/27/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit
class Passage {
    var id: Int?
    var authorId: Int?
    var authorName: String?
    var content:String?
    var title:String?
    var createTime: String?
    var viewCount: Int?
    
    init() {
        
    }
    
    init(id:Int, authorId:Int, authorName:String, title:String, content:String, createTime:String, viewCount:Int) {
        self.id = id
        self.authorId = authorId
        self.authorName = authorName
        self.title = title
        self.content = content
        self.createTime = createTime
        self.viewCount = viewCount
    }
}