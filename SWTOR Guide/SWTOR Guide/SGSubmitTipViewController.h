//
//  SGSubmitTipViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-12-01.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGSubmitTipViewController;

@protocol SGSubmitTipViewDelegate <NSObject>
-(void)submitTipControllerDidCancel:(SGSubmitTipViewController*)submitTipController;
-(void)submitTipControllerDidSubmit:(SGSubmitTipViewController*)submitTipController;
@end

@interface SGSubmitTipViewController : UIViewController <UITextViewDelegate>
@property (assign) id<SGSubmitTipViewDelegate> delegate;
@property (assign) IBOutlet UITextField* titleTextField; 
@property (assign) IBOutlet UITextView* textView;

-(void)displayError:(NSString*)errorString;
-(IBAction)cancel:(id)sender;
-(IBAction)proceed:(id)sender;
@end
