//
//  ViewController.m
//  test HTML to String
//
//  Created by Will on 1/1/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString *html =
      @"<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>";
  NSLog(@"----------->%@", [self convertHTML:html]);
}

- (NSString *)convertHTML:(NSString *)html {

  NSScanner *myScanner;
  NSString *text = nil;
  myScanner = [NSScanner scannerWithString:html];

  while ([myScanner isAtEnd] == NO) {

    [myScanner scanUpToString:@"<" intoString:NULL];

    [myScanner scanUpToString:@">" intoString:&text];

    html = [html
        stringByReplacingOccurrencesOfString:[NSString
                                                 stringWithFormat:@"%@>", text]
                                  withString:@""];
  }
  
  html = [html
      stringByTrimmingCharactersInSet:[NSCharacterSet
                                          whitespaceAndNewlineCharacterSet]];

  return html;
}

@end
