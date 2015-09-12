//
//  MoveViewController.h
//  Move
//
//  Created by Jeroen van Rijn on 29-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveViewController : UIViewController {
    
    IBOutlet UIScrollView *theScrollView;
    
    UITextField *activeTextField;
}
@property (nonatomic, assign) UITextField *activeTextField;

- (IBAction)dismissKeyboard:(id)sender;


@end
