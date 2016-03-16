//
//  ViewController.m
//  testEmojiToUnicode
//
//  Created by Will on 1/13/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSData *data =
      [@"" dataUsingEncoding:NSNonLossyASCIIStringEncoding];
  NSString *goodValue =
      [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]
          autorelease];

  goodValue =
      [goodValue stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
}

@end
