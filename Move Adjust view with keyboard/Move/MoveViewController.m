//
//  MoveViewController.m
//  Move
//
//  Created by Jeroen van Rijn on 29-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveViewController.h"

@implementation MoveViewController

@synthesize activeTextField;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [theScrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
      
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
        
    
}
 

- (void)viewDidUnload
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [theScrollView release];
    theScrollView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)keyboardWasShown:(NSNotification *)notification 
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y - (keyboardSize.height-15));
        [theScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
}

// Set activeTextField to the current active textfield

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField; 
}

// Set activeTextField to nil

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}


// Dismiss the keyboard

- (IBAction)dismissKeyboard:(id)sender
{
    [self.activeTextField resignFirstResponder];
}

@end
