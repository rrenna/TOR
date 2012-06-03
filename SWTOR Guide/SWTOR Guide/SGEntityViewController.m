//
//  SGEntityViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-04.
//  Copyright 2011 None. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGEntityViewController.h"

#pragma mark - Helper functions
void moveViewForSavedSpace(UIView* view, int space)
{
    CGRect initialRect = view.frame;
    initialRect.origin.y -= space;
    view.frame = initialRect;
}
void resizeViewForSavedSpace(UIView* view, int space)
{
    CGRect initialRect = view.frame;
    initialRect.size.height -= space;
    view.frame = initialRect;
}
void resizeContentSizeForSavedSpace(UIScrollView* scrollview,int space)
{
    CGSize initialSize = scrollview.contentSize;
    initialSize.height -= space;
    scrollview.contentSize = initialSize;
}
int resizeLabelToTopAlignmentReturningHeightReduced(UILabel *label) 
{
    int initialHeight = label.frame.size.height;
    CGSize terrainTextSize = [label.text sizeWithFont:label.font
                                    constrainedToSize:label.frame.size 
                                        lineBreakMode:label.lineBreakMode];
    
    CGRect terrainFrame = CGRectMake(label.frame.origin.x,label.frame.origin.y, terrainTextSize.width, terrainTextSize.height);
    
    label.frame = terrainFrame;
    return (initialHeight - terrainFrame.size.height);
}
UIColor* colorForEntity(id entity)
{
    const float alpha = 0.95;
    
    if([entity respondsToSelector:@selector(characterClassesCompanion)])
    {
        //Companion
        static UIColor* companionColour;
        
        if(!companionColour)
        {
            companionColour = [[UIColor colorWithRed:(27.0/255.0) green:(27.0/255.0) blue:(29.0/255.0) alpha:alpha] retain];
        }
        
        return companionColour;
    }
    else if([entity respondsToSelector:@selector(reliedOnBy)])
    {
        //Crafting Skill
        static UIColor* craftingSkillColour;
        
        if(!craftingSkillColour)
        {
            craftingSkillColour = [[UIColor colorWithRed:(15.0/255.0) green:(20.0/255.0) blue:(28.0/255.0) alpha:alpha] retain];
        }
        
        return craftingSkillColour;
    }
    else if([entity respondsToSelector:@selector(skills)])
    {
        //Crafting Skill
        static UIColor* skillTreeColour;
        
        if(!skillTreeColour)
        {
            skillTreeColour = [[UIColor colorWithRed:(34.0/255.0) green:(34.00/255.0) blue:(34.0/255.0) alpha:alpha] retain];
        }
        
        return skillTreeColour;
    }
    else if([entity respondsToSelector:@selector(modifier)])
    {
        //Datacron
        return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.15];
    }
    return [UIColor blackColor];
}
@implementation SGEntityViewController
#pragma mark - instance methods
-(id)initWithEntity:(id)entity andXibName:(NSString*)nibNameOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self)
    {
        _entity = [entity retain];
        self.title = [_entity valueForKey:@"Name"];
    }
    return self;
}
-(void)dealloc
{
    [_entity release];
    [_tipController release];
    [super dealloc];
}
-(id)initWithEntity:(id)entity
{
    //Template method
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self didTapTabNamed:@"General"];
    
    //Add default tab to the tabbar
    [tabView setDelegate:self];
    [tabView addTabNamed:@"General" selected:YES];
    [tabView addTabNamed:@"Tips" selected:NO];
    
    previewImageView.backgroundColor = colorForEntity(_entity);
    previewImageView.image = [UIImage imageNamed:[_entity valueForKey:@"PreviewBackgroundFilename"]];
    
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    [shareButton release];
}
-(UIView*)dividerForTitle:(NSString*)title withIconKey:(NSString*)iconKey
{
    UIImageView* dividerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_FOR_DIVIDER)] autorelease];
    dividerView.image = [UIImage imageNamed:@"divider.png"];
    dividerView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* dividerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(13, 0, 307, HEIGHT_FOR_DIVIDER)] autorelease];
    dividerLabel.backgroundColor = [UIColor clearColor];
    dividerLabel.textColor = [UIColor darkGrayColor];
    dividerLabel.shadowColor = [UIColor whiteColor];
    dividerLabel.shadowOffset = CGSizeMake(0,1);
    dividerLabel.text = title; 
    
    [dividerView addSubview:dividerLabel];
    return dividerView;

}
#define CELL_HEIGHT 30
-(UIView*)backgroundViewForEntity:(id)entity
{
    CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
    
    NSString* planetPreviewFilename = [entity valueForKey:@"PreviewBackgroundFilename"];
    UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
    
    UIView* backgroundView = [[[UIView alloc] initWithFrame:cellRect] autorelease];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.backgroundColor = colorForEntity(entity);
    
    UIImageView* contentImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
    contentImageView.image = backgroundImage;
    contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundView addSubview:contentImageView];
    
    return backgroundView;
}
-(void)resizeForGeneralTab
{
    //Stub Method
}
-(NSString*)htmlHeaderForSummary
{
    return [NSString stringWithFormat: @"<html><body style='backgroundColor:grey;width:100%;height:100%;font-family: 'HelveticaNeue-Light''><div><b>%@</b>", [_entity Name]];
}
-(NSString*)htmlSummaryOfEntity
{
    if([_entity respondsToSelector:@selector(Headline)])
    {
        if([_entity valueForKey:@"Description"] == nil)
        {
            //Some entities only have Headlines
            return [NSString stringWithFormat:@"<br/><br/><i>%@</i>",[_entity valueForKey:@"Headline"]];
        }
        
        return [NSString stringWithFormat:@"<br/><i>%@</i><br/><br/>%@",[_entity valueForKey:@"Headline"],[_entity valueForKey:@"Description"]];
    }
    else
    {
        return [NSString stringWithFormat:@"<br/><br/>%@",[_entity valueForKey:@"Description"]];
    }
}
-(NSString*)htmlFooterForSummary
{
    return @"</div><br/><div><i>Get the ultimate Old Republic database, in the palm of your hand. <b>T.O.R. Codex</b> is avaliable on iOS now!</i><br/><br/><a href='http://itunes.apple.com/app/t.o.r.-guide/id463743698?mt=8'><img src='https://developer.apple.com/appstore/images/as_available_appstore_icon_20091006.png'/></a></div></body></html>";
}
#pragma mark - IBActions
#define ACTION_SHARE @"Share"
#define ACTION_REPORT_ERROR @"Report Error"
//Opens an action sheet, presenting various sharing options 
-(IBAction)share:(id)sender
{
    UIActionSheet* shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:ACTION_SHARE,ACTION_REPORT_ERROR, nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [shareActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}
-(IBAction)reportError:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        NSString* appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        NSString* iOSVersion = [[UIDevice currentDevice] systemVersion];
        NSString* entityName = [_entity Name];
        
        MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
        mailComposeController.mailComposeDelegate = self;
        
        NSString* supportEmailAddress = @"offblastsoftworks@gmail.com";
        NSString* subject = [NSString stringWithFormat:@"Error in T.O.R. Codex version %@",appVersion];
        NSString* body = [NSString stringWithFormat:@"Description of Error: \n\n\n\n Entity Name: %@\niOS Version: %@",entityName,iOSVersion];
        
        [mailComposeController setToRecipients:[NSArray arrayWithObject:supportEmailAddress]];
        [mailComposeController setSubject:subject];
        [mailComposeController setMessageBody:body isHTML:NO];
        
        [self presentModalViewController:mailComposeController animated:YES];
    }
    else
    {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You don't seem to have an email address setup on this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
        [alert show];
    }
}
-(IBAction)emailEntity:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
        mailComposeController.mailComposeDelegate = self;

        NSString* subject = [NSString stringWithFormat:@"Info on '%@' from T.O.R. Codex",[_entity Name]];
        NSString* body = [NSString stringWithFormat:@"%@%@%@",[self htmlHeaderForSummary],[self htmlSummaryOfEntity],[self htmlFooterForSummary]];
    
        [mailComposeController setSubject:subject];
        [mailComposeController setMessageBody:body isHTML:YES];
        [self presentModalViewController:mailComposeController animated:YES];
    }
    else
    {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You don't seem to have an email address setup on this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
        [alert show];
    }
}
#pragma mark - UITableView Delegate & Datasource methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_FOR_DIVIDER;
}
#pragma mark - UIActionSheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    //Share
    if([buttonTitle isEqualToString:ACTION_SHARE])
    {
        [self emailEntity:nil];
    }
    //Report Error
    else if([buttonTitle isEqualToString:ACTION_REPORT_ERROR])
    {
        [self reportError:nil];
    }
}
#pragma mark - MFMailCompose delegate methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - BHTabsViewDelegate methods
- (void)didTapTabNamed:(NSString *)tabName
{
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if([tabName isEqualToString:@"General"])
    {
        [scrollView addSubview:contentView];
        scrollView.contentSize = contentView.frame.size;
    }
    else if([tabName isEqualToString:@"Tips"])
    {
        if(!_tipController)
        {
            _tipController = [SGTipController new];
            //Set the appropriate parse type to query
            NSString* entityClassName = [[_entity entity] name];
            _tipController.parentViewController = self;
            _tipController.parseType = [NSString stringWithFormat:@"%@_Tip",entityClassName];
            _tipController.entityName = [_entity valueForKey:@"Name"];
            
            CGRect frame = CGRectMake(0, 0, 320, 365);
            _tipController.tableView = [[[UITableView alloc] initWithFrame:frame] autorelease];
            [_tipController.tableView setDelegate:_tipController];
            [_tipController.tableView setDataSource:_tipController];
            [_tipController.tableView setBackgroundColor:[UIColor clearColor]];
            [_tipController.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
        
        [scrollView setContentSize:_tipController.tableView.frame.size];
        [scrollView addSubview:_tipController.tableView];
        [scrollView setContentOffset:CGPointMake(0, 0)];
        [_tipController getTips];
    }
}
@end
