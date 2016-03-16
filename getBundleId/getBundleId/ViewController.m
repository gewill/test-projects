//
//  ViewController.m
//  getBundleId
//
//  Created by Will on 2/7/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import "ViewController.h"
#include <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
