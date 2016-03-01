//
//  Global.swift
//  blog
//
//  Created by Leo on 3/1/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import Foundation

class Global {

    static let server = "https://www.huzhonghua.cn/app"
//    static let server = "http://192.168.133.1:9000/app"
    static let passageListURL = "/index"
    static let loginURL = "/login"
    static let passageURL = "/passage"
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func encodeChinese() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
}