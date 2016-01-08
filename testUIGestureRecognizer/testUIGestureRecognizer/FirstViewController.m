//
//  FirstViewController.m
//  testUIGestureRecognizer
//
//  Created by Will on 1/5/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)performAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手势" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}
- (void)performSwipeGesture:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"performSwipeGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"轻扫"];
    }
}
- (void)performRotationSwipeGesture:(UIRotationGestureRecognizer *)recognizer
{
    
    NSLog(@"PerformRotationSwipeGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"旋转"];
    }
}

- (void)performLongPressGesture:(UILongPressGestureRecognizer *)recognizer
{
    NSLog(@"performLongPressGesture:");
    
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"长按"];
    }
}
- (void)performTapGesture:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"performTapGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"点击"];
    }
}
- (void)performPinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"performPinchGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"缩放"];
    }
}
- (void)performPanGesture:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"performPanGesture:");
    if(recognizer.state == UIGestureRecognizerStateEnded){
        [self performAlert:@"拖动"];
    }
}

- (void)view:(UIView *)view addGestureRecognizer:(NSInteger)type
    delegate:(id<UIGestureRecognizerDelegate>)delegate
{
    UIGestureRecognizer *recognizer = nil;
    SEL action = nil;
    switch (type) {
        case LongPressGestureRecognizer:
            action = @selector(performLongPressGesture:);
            recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PanGestureRecognizer:
            action = @selector(performPanGesture:);
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PinchGestureRecognizer:
            action = @selector(performPinchGesture:);
            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case RotationGestureRecognizer:
            action = @selector(performRotationSwipeGesture:);
            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case SwipeGestureRecognizer:
            action = @selector(performSwipeGesture:);
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case TapGestureRecognizer:
            action = @selector(performTapGesture:);
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTapsRequired = 1;
            break;
        default:
            return;
    }
    recognizer.delegate = delegate;
    [view addGestureRecognizer:recognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int i = 0; i < RecognizerTypeCount; ++ i) {
        [self view:self.view addGestureRecognizer:i delegate:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.view) {
        return YES;
    }
    return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
