//
//  Global.swift
//  blog
//
//  Created by Leo on 3/1/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import Foundation

class Global {

    static let server = "https://www.huzhonghua.cn"
//    static let server = "http://192.168.133.1:9000"
    static let passageListURL = "/app/index"
    static let loginURL = "/app/login"
    static let passageURL = "/passage"
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}