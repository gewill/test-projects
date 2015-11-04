//
//  ViewController.swift
//  test Core Data
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // Cora Data already settled done in AppDelegate.swift
        // get the ManagedObjectContext
        var appDel = UIApplication .sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // get the ManagedObject
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) 
        
        // set value for key
        newUser.setValue("" + textUserName.text, forKey: "username")
        newUser.setValue("" + textPassword.text, forKey: "password")
        
        do {
            // save
            try context.save()
        } catch _ {
        }
        print("New username: \(textPassword.text) and password: \(textPassword.text) saved successfully.\n", terminator: "")
        
        
    }
  
    @IBAction func loadButton(sender: AnyObject) {
        
        var appDel = UIApplication .sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        // add FetchRequest and add Predicate/ SortDescriptor etc.
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", "" + textUserName.text)
        
        var requests: NSArray = try! context.executeFetchRequest(request)
        
        if (requests.count > 0) {
            
            var res = requests[0] as! NSManagedObject
            textUserName.text = res.valueForKeyPath("username") as! String
            textPassword.text = res.valueForKeyPath("password") as! String
            
        } else {
            
            print("0 Results Returned... Poterial Error.\n", terminator: "")
        }
        
    }
}

