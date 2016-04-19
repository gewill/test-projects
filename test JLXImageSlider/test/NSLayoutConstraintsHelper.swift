//
//  NSLayoutConstraintsHelper.swift
//  5News
//
//  Created by Will on 3/5/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

/**
 Swift NSDictionaryOfVariableBindings substitute
 
 - parameter arr: UIView array: (view1, view2)
 
 - returns: return ["v1": UIView, "v2": view2]
 */
func dictionaryOfNames(arr: UIView ...) -> [String: UIView] {
    var d = [String: UIView]()
    for (ix, v) in arr.enumerate() {
        d["v\(ix+1)"] = v
    }
    return d
}