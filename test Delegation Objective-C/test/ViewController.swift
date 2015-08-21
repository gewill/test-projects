//
//  ViewController.swift
//  test
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AddItemViewControllerDelegate {
    func addItem(send: AnyObject) {
        // Initialize View Controller
        let viewController = AddItemViewController()
        
        // Configure View Controller
        viewController.delegate = self
        
        // Present View Controller
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func viewControllerDidCancel(viewController: AddItemViewController) {
        // Dismiss Add Item View Controller
    }
    
    func viewController(viewController: AddItemViewController, didAddItem: String) {
        
    }
    
    func viewController(viewController: AddItemViewController, validateItem: String) -> Bool {
        
        return true;
    }
}

