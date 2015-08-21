//
//  AddItemViewController.h
//  test Delegation
//
//  Created by Will Ge on 8/21/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddItemViewControllerDelegate;

@interface AddItemViewController : UIViewController

@property (weak, nonatomic) id<AddItemViewControllerDelegate> delegate;

@end

@protocol AddItemViewControllerDelegate <NSObject>
- (void)viewControllerDidCancel:(AddItemViewController *)viewController;
- (void)viewController:(AddItemViewController *)viewController didAddItem:(NSString *)item;

@optional
- (BOOL)viewController:(AddItemViewController *)viewController validateItem:(NSString *)item;
@end
