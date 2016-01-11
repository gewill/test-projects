//
//  Article.swift
//  test MJExtension Swift
//
//  Created by Will on 1/8/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit


class Article: NSObject {
    var id: String!
    var title: String!
    var zImage: String!
 
   override static func mj_replacedKeyFromPropertyName121(propertyName: String!) -> String! {
        return propertyName.mj_underlineFromCamel()
    }
    
}

class Response: NSObject {
    var state: String!
    var result: Result!
    

}

class Result: NSObject {
    var pageCount: String!
    var page: String!
    var lastTime: String!
    
    var banners: [AnyObject]!
    var articles: [AnyObject]!
    
   override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["banners": "Article", "articles": "Article"]
    }

}