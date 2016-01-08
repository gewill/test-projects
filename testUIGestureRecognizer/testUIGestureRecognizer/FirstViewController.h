//
//  FirstViewController.h
//  testUIGestureRecognizer
//
//  Created by Will on 1/5/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LongPressGestureRecognizer = 0,
    PanGestureRecognizer,
    PinchGestureRecognizer,
    RotationGestureRecognizer,
    SwipeGestureRecognizer,
    TapGestureRecognizer,
    RecognizerTypeCount
}RecognizerType;

@interface FirstViewController : UIViewController <UIGestureRecognizerDelegate>{
    
}

@end
