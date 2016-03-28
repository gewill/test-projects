//
//  ViewController.m
//  test blur
//
//  Created by Will on 3/19/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import "FXBlurView.h"
#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic) IBOutlet UIImageView *img;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.img.image = [UIImage imageNamed:@"kloss.jpg"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
