//
//  SGNameGeneratorViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SGViewController.h"

@interface SGNameGeneratorViewController : SGViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel* nameLabel;
    IBOutlet UISegmentedControl* sexSegmentedControl;
    IBOutlet UITableView* tableView;
    
    BOOL maleNames;
    NSArray* maleNameFormats;
    NSArray* femaleNameFormats;
}
@property (retain) NSMutableArray* previousNames; 

-(IBAction)generate:(id)sender;
-(IBAction)switchGender:(id)sender;

-(IBAction)share:(id)sender;
-(IBAction)emailNames:(id)sender;
@end
