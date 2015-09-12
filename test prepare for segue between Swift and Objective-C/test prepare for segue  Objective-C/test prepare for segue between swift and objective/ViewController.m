//
//  ViewController.m
//  test prepare for segue between swift and objective
//
//  Created by Will Ge on 9/5/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()

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

#pragma mark - Navigation


// In Swift should check the method, even user don't tap the cantainer view.
// But in Objective-C,  *** Terminating app due to uncaught exception 'NSInvalidUnarchiveOperationException', reason: 'Could not instantiate class named AVPlayerViewController'
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // set up the player
    if ([segue.identifier  isEqual: @"videoSegue"]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"yishengsuoai" ofType:@"mp4"];
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        
        AVPlayerViewController *vc = segue.destinationViewController;
        vc.player = [AVPlayer playerWithURL:url];
    }

    
}

@end
