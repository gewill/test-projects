//
//  ViewController.m
//  test
//
//  Created by Will on 12/30/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"
@import Foundation;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

  NSDate *date =
      [dateFormatter dateFromString:@"Tue Dec 30 16:35:54 +0800 2014"];
  NSLog(@"-------%@", [dateFormatter stringFromDate:date]);
  
  NSLog(@"+++++++%@", [self relativeDateStringForDate:date]);
    
}

- (NSString *)relativeDateStringForDate:(NSDate *)date {
  NSCalendarUnit units = NSCalendarUnitSecond | NSCalendarUnitMinute |
                         NSCalendarUnitHour | NSCalendarUnitDay |
                         NSCalendarUnitWeekOfYear | NSCalendarUnitMonth |
                         NSCalendarUnitYear;

  // if `date` is before "now" (i.e. in the past) then the components will be
  // positive
  NSDateComponents *components =
      [[NSCalendar currentCalendar] components:units
                                      fromDate:date
                                        toDate:[NSDate date]
                                       options:0];

  if (components.year > 0) {
    return [NSString stringWithFormat:@"%ldy", (long)components.year];
  } else if (components.month > 0) {
    return [NSString stringWithFormat:@"%ldm", (long)components.month];
  } else if (components.weekOfYear > 0) {
    return [NSString stringWithFormat:@"%ldw", (long)components.weekOfYear];
  } else if (components.day > 0) {
    return [NSString stringWithFormat:@"%ldd", (long)components.day];
  } else if (components.hour > 0) {
    return [NSString stringWithFormat:@"%ldh", (long)components.hour];
  } else if (components.minute > 0) {
    return [NSString stringWithFormat:@"%ldm", (long)components.minute];
  } else if (components.second > 0) {
    return [NSString stringWithFormat:@"%lds", (long)components.second];
  } else {
    return [NSString stringWithFormat:@"<1s"];
  }
}

@end
