//
//  AddItemViewController.m
//  test Delegation
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidCancel:)]) {
        [self.delegate viewControllerDidCancel:self];
    }
}

@end
