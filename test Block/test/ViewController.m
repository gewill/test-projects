//
//  ViewController.m
//  test
//
//  Created by Will Ge on 9/12/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // 1 - Use __block Variables to Share Storage
  __block int anInteger = 42;

  void (^testBlock)(void) = ^{
    NSLog(@"Integer is: %i", anInteger);
  };

  anInteger = 84;

  testBlock();

  // 2 - Blocks Can Simplify Enumeration
  NSArray *array = @[ @"a", @"b", @"c" ];

  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSLog(@"%@, %@", array[idx], obj);
  }];

  // 3 - Schedule Blocks on Dispatch Queues with Grand Central Dispatch
  dispatch_queue_t queue0 = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);

  dispatch_async(queue0, ^{
    for (long long idx = 0; idx < 1000000000000000; idx++) {
      NSLog(@"%lld: Schedule Blocks on Dispatch Queues with Grand Central "
            @"Dispatch.",
            idx);
    }
  });

  // 4 - Use Block Operations with Operation Queues
  NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"Block1");
  }];

  [operation addExecutionBlock:^{
    NSLog(@"Block2");
  }];

  [operation start];

  // schedule task on main queue:
  NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
  [mainQueue addOperation:operation];

  // schedule task on background queue:
  NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
  [queue1 addOperation:operation];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
