//
//  AddItemViewController.swift
//  test
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: NSObjectProtocol {
    func viewControllerDidCancel(viewController: AddItemViewController)
    func viewController(viewController: AddItemViewController, didAddItem: String)
    func viewController(viewController: AddItemViewController, validateItem: String) -> Bool
}

class AddItemViewController: UIViewController {
    var delegate: AddItemViewControllerDelegate?
    
    func cancel(sender: AnyObject) {
        delegate?.viewControllerDidCancel(self)
    }
}