//
//  ViewController.m
//  test GCD
//
//  Created by Will Ge on 9/12/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Set image to placeholder first
  NSString *string = @"http://gewill.org/favicon_new.png";
  NSURL *url = [NSURL URLWithString:string];
  NSData *data = [NSData dataWithContentsOfURL:url];
  UIImage *placeholder = [UIImage imageWithData:data];
  self.image.image = placeholder;

  ViewController *__weak weakSelf = self;

  NSOperationQueue *q = [[NSOperationQueue alloc] init];
  [q addOperationWithBlock:^{

    NSString *string =
        @"https://images.unsplash.com/uploads/141158921208966d7e1c0/"
        @"3d948285?q=80&fm=jpg&s=f7f244fbd46564ddfdf587c06febc116";
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      weakSelf.image.image = image;
    }];

  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
