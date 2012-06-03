//
//  SGEntityViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-04.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SGViewController.h"
#import "SGTipController.h"
#import "BHTabsView.h"

#define HEIGHT_FOR_DIVIDER 40
//Helper function definitions
void moveViewForSavedSpace(UIView* view, int space);
void resizeViewForSavedSpace(UIView* view, int space);
void resizeContentSizeForSavedSpace(UIScrollView* scrollview,int space);
int resizeLabelToTopAlignmentReturningHeightReduced(UILabel *label);
UIColor* colorForEntity(id entity);

@interface SGEntityViewController : SGViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate,BHTabsViewDelegate>
{
    IBOutlet UIImageView* previewImageView;
    IBOutlet UILabel* DescriptionLabel;
    IBOutlet UIView* contentView;
    IBOutlet UIScrollView* scrollView;
    IBOutlet BHTabsView* tabView;
    id _entity;
    @private
    SGTipController* _tipController;
}

-(id)initWithEntity:(id)entity andXibName:(NSString*)nibNameOrNil;
-(id)initWithEntity:(id)entity;
-(UIView*)dividerForTitle:(NSString*)title withIconKey:(NSString*)iconKey;
-(UIView*)backgroundViewForEntity:(id)entity;
-(void)resizeForGeneralTab;
//Generates an HTML string which summarizes the content on an entity viewer
-(NSString*)htmlSummaryOfEntity;
-(NSString*)htmlHeaderForSummary;
-(NSString*)htmlFooterForSummary;

-(IBAction)share:(id)sender;
-(IBAction)reportError:(id)sender;
-(IBAction)emailEntity:(id)sender;
@end
