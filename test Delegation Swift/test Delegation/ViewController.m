//
//  ViewController.m
//  test Delegation
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"
#import "AddItemViewController.h"

@interface ViewController () <AddItemViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender {
    // Initialize View Controller
    AddItemViewController *viewController = [[AddItemViewController alloc] init];
    
    // Configure View Controller
    [viewController setDelegate:self];
    
    // Present View Controller
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)viewControllerDidCancel:(AddItemViewController *)viewController {
    // Dismiss Add Item View Controller
    
}

@end
