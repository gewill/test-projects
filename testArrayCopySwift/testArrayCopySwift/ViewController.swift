//
//  ViewController.swift
//  test Array Copy Swift
//
//  Created by Will on 12/14/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //copy array swift
    var array1 = [1, 2, 3, 4, 5]
    var array4 = array1
    var arrayPtr1 = UnsafeMutableBufferPointer<Int>(start: &array1, count: array1.count)
    var arrayPtr4 = UnsafeMutableBufferPointer<Int>(start: &array4, count: array4.count)
    print(array1)
    print(array4)
    print(arrayPtr1)
    print(arrayPtr4)
    
    
    array1[0] = 10
    array1.append(20)
    print(array1)
    print(array4)
    var arrayPtr7 = UnsafeMutableBufferPointer<Int>(start: &array1, count: array1.count)
    var arrayPtr8 = UnsafeMutableBufferPointer<Int>(start: &array4, count: array4.count)
    print(arrayPtr7)
    print(arrayPtr8)
    
    
    // Swift Memory UnsafePointer
    var array = [1, 2, 3, 4, 5]
    var arrayPtr = UnsafeMutableBufferPointer<Int>(start: &array, count: array.count)
    // baseAddress 是第一个元素的指针
    var basePtr = arrayPtr.baseAddress as UnsafeMutablePointer<Int>
    print(basePtr.memory) // 1
    basePtr.memory = 10
    print(basePtr.memory) // 10
    //下一个元素
    var nextPtr = basePtr.successor()
    print(nextPtr.memory) // 2
    print(array) // [10, 2, 3, 4, 5]
    
    
  }
  
  
  
  
}

