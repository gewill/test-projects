//
//  ViewController.m
//  test
//
//  Created by Will on 12/14/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

  [super viewDidLoad];

  //第一层理解:
  //如果对一个不可变容器复制，copy是指针复制，即浅拷贝。
  //如果对一个可变容器复制，copy是对象复制，即深拷贝。
  NSArray *array = [NSArray array];
  NSArray *array2 = [array copy];
  NSLog(@"%p and %p", array, array2);

  NSMutableArray *marray = [NSMutableArray array];
  NSMutableArray *marray2 = [marray copy];
  NSLog(@"%p and %p", marray, marray2);

  //  第二层理解:
  //  如果是对可变容器copy,是对象复制,即深拷贝,但拷贝出的是一个不可变容器。
  //  如果是对可变容器mutableCopy才符合正确地copy语义,也是对象复制,即深拷贝,这次拷贝出的是一个可变容器。
  NSMutableArray *array3 = [NSMutableArray array];
  NSLog(@"%@", [array3 class]);
  [array3 addObject:@"Panda"];

  NSMutableArray *array4 = [array3 mutableCopy];
  NSLog(@"%@", [array4 class]);
  [array4 addObject:@"Lion"]; //成功

  NSMutableArray *array5 = [array3 copy];
  NSLog(@"%@", [array5 class]);
  //[array5 addObject:@"Lion"]; //报错

  //  第三层理解:
  //  上述的深拷贝其实还不是完全深拷贝,因为第二层的图可以发现mutableCopy的数组仍然共享同样的数组元素。
  //  而完全深拷贝即是对数组元素同样的拷贝的真正深拷贝。
  NSMutableArray *marray3 = [NSMutableArray array];
  [marray3 addObject:@"Panda"];
  NSMutableArray *marray4 = [marray3 mutableCopy]; //一般深拷贝
  [marray4 addObject:@"Li"];
  NSMutableArray *marray5 = [NSKeyedUnarchiver
      unarchiveObjectWithData:
          [NSKeyedArchiver archivedDataWithRootObject:marray3]]; //完全深拷贝
  NSLog(@"数组第一个元素的指针 -> 1:%p \n 2:%p \n 3:%p", marray3[0],
        marray4[0], marray5[0]);
  NSLog(@"数组的指针 -> 1:%p \n 2:%p \n 3:%p", marray3, marray4, marray5);
}

@end
