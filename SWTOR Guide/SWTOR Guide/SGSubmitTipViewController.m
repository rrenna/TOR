//
//  SGSubmitTipViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-12-01.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGSubmitTipViewController.h"

@implementation SGSubmitTipViewController


#pragma mark - View lifecycle
@synthesize textView,titleTextField, delegate;

-(id)init
{
    self = [self initWithNibName:@"SGSubmitTipViewController" bundle:nil];
    if(self)
    {
        
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark
-(void)displayError:(NSString*)errorString
{
    //
}
#pragma mark - IBActions
-(IBAction)cancel:(id)sender
{
    [delegate submitTipControllerDidCancel:self];
}
-(IBAction)proceed:(id)sender
{
    [delegate submitTipControllerDidSubmit:self];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.frame = CGRectMake(0, 87, 320, 155);
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.frame = CGRectMake(0, 87, 320, 373);
}
@end
