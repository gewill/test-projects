//
//  Article.swift
//  test MJExtension Swift
//
//  Created by Will on 1/8/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit


class Article: NSObject {
    var id: NSString!
    var title: NSString!
    var zImage: NSString!
 
   override static func mj_replacedKeyFromPropertyName121(propertyName: String!) -> String! {
        return propertyName.mj_underlineFromCamel()
    }
    
}

class Response: NSObject {
    var state: NSString!
    var result: Result!
    

}

class Result: NSObject {
    var pageCount: NSString!
    var page: NSString!
    var lastTime: NSString!
    
    var banners: NSArray!
    var articles: NSArray!
    
   override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["banners": "Article", "articles": "Article"]
    }

}