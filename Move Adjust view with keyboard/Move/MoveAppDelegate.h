//
//  MoveAppDelegate.h
//  Move
//
//  Created by Jeroen van Rijn on 29-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoveViewController;

@interface MoveAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MoveViewController *viewController;

@end
