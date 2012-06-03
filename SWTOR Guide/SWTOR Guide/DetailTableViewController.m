//
//  DetailTableViewController.m
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "DetailTableViewController.h"
#import "NSString+HTML.h"
#import "AZLoginViewController.h"

typedef enum { SectionHeader, SectionDetail } Sections;
typedef enum { SectionHeaderDate, SectionHeaderURL } HeaderRows;
typedef enum { SectionDetailSummary,SectionReadButton } DetailRows;

@implementation DetailTableViewController

@synthesize item, dateString, summaryString;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];

	// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		self.dateString = [formatter stringFromDate:item.date];
		[formatter release];
	}
	
	// Summary
	if (item.summary) {
		self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
	} else {
		self.summaryString = @"[No Summary]";
	}
    
    //Setup background
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"Background.png"];
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.tableView.backgroundView = backgroundImageView;
    
    //Add share button
    UIBarButtonItem* shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    [shareButton release];
}

#pragma mark - IBActions
-(IBAction)read:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.link]];
}
-(IBAction)readLater:(id)sender
{
    NSString* instapaperAuth =  [[NSUserDefaults standardUserDefaults] valueForKey:@"INSTAPAPER_AUTH"];
    NSString* instapaperSecret = [[NSUserDefaults standardUserDefaults] valueForKey:@"INSTAPAPER_SECRET"];
    IKEngine* engine = [[SGAppDelegate delegate] engine];
    engine.delegate = self;

    if(instapaperAuth && instapaperSecret)
    {
        // Assign token and secret
        engine.OAuthToken  = instapaperAuth;
        engine.OAuthTokenSecret = instapaperSecret;
        [engine verifyCredentialsWithUserInfo:nil];
    }
    else
    {
        AZLoginViewController* login = [AZLoginViewController new];
        [self.navigationController pushViewController:login animated:YES];
    }
}
//Opens an action sheet, presenting various sharing options 
-(IBAction)share:(id)sender
{
    UIActionSheet* shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share",nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [shareActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}
-(IBAction)emailArticle:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
        mailComposeController.mailComposeDelegate = self;
        
        NSString* subject = @"Shared Article from T.O.R. Codex";
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";

        
        NSMutableString* body = [NSMutableString stringWithFormat:@"<html><body><b>%@</b></br><br/><div>%@</div><br/><br/><a href='%@'>Read Article</a><br/>",itemTitle,summaryString,item.link];

        [body appendString:@"</div><br/><div><i>Get the ultimate Old Republic database, in the palm of your hand. <b>T.O.R. Codex</b> is avaliable on iOS now!</i><br/><br/><a href='http://itunes.apple.com/app/t.o.r.-guide/id463743698?mt=8'><img src='https://developer.apple.com/appstore/images/as_available_appstore_icon_20091006.png'/></a></div></body></html>"];
        
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
#pragma mark - UIActionSheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    //Share
    if([buttonTitle isEqualToString:@"Share"])
    {
        [self emailArticle:nil];
    }
}
#pragma mark - Instapaper Delegate methods
- (void)engine:(IKEngine *)engine connection:(IKURLConnection *)connection didVerifyCredentialsForUser:(IKUser *)user
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear networkIndicator:YES];
    
    NSURL* url = [NSURL URLWithString:self.item.link];
    [engine addBookmarkWithURL:url userInfo:nil];
}
- (void)engine:(IKEngine *)engine connection:(IKURLConnection *)connection didAddBookmark:(IKBookmark *)bookmark
{
    engine.delegate = nil;
    [SVProgressHUD dismissWithSuccess:@"Sent to Instapaper"];
}
- (void)engine:(IKEngine *)engine didFailConnection:(IKURLConnection *)connection error:(NSError *)error
{
    //Dismiss any active progress hud
    [SVProgressHUD dismissWithError:@"Problem sending to Instapaper"];
    
    //verifying credentials failed, reset stored credentials
    engine.delegate = nil;
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"INSTAPAPER_AUTH"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"INSTAPAPER_SECRET"];
}
#pragma mark - MFMailCompose delegate methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0: return 1;
		default: return 2;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 40;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        
        UIImageView* dividerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
        dividerView.image = [UIImage imageNamed:@"divider.png"];
        dividerView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel* dividerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 305, 40)] autorelease];
        dividerLabel.backgroundColor = [UIColor clearColor];
        dividerLabel.textColor = [UIColor darkGrayColor];
        dividerLabel.shadowColor = [UIColor whiteColor];
        dividerLabel.shadowOffset = CGSizeMake(0,1);
        dividerLabel.text = itemTitle; 
        
        [dividerView addSubview:dividerLabel];
        return dividerView;
    }
    
    return nil;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
	if (item) {
		
		// Item Info
		//NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Display
		switch (indexPath.section) {
			case SectionHeader: {
				
				// Header
				switch (indexPath.row) 
                {
					case SectionHeaderDate:
                        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
                        cell.textLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
						cell.textLabel.text = dateString ? dateString : @"[No Date]";
                        cell.textLabel.textAlignment = UITextAlignmentCenter;
						break;
				}
				break;
				
			}
			case SectionDetail: 
            {
                if(indexPath.row == SectionDetailSummary)
                {
                    UIImage* backgroundImage = [UIImage imageNamed:@"newsBackground.png"];
                    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
                    
                    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
                    cell.backgroundView = backgroundImageView;
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    cell.textLabel.shadowColor = [UIColor whiteColor];
                    cell.textLabel.shadowOffset = CGSizeMake(0,1);
                    
                    // Summary
                    cell.textLabel.text = summaryString;
                    cell.textLabel.numberOfLines = 6;
  
                }
                else if(indexPath.row == SectionReadButton)
                {
                    UIButton* readButton = [[[UIButton alloc] initWithFrame:CGRectMake(12, 1, 144, 46)] autorelease];
                    [readButton setBackgroundImage:[UIImage imageNamed:@"ConfirmButton"] forState:UIControlStateNormal];
                    [readButton setTitle:@"Read" forState:UIControlStateNormal];
                    [readButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [readButton addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell addSubview:readButton];
                    
                    UIButton* readLaterButton = [[[UIButton alloc] initWithFrame:CGRectMake(160, 1, 144, 46)] autorelease];
                    [readLaterButton setBackgroundImage:[UIImage imageNamed:@"ConfirmButton"] forState:UIControlStateNormal];
                    [readLaterButton setTitle:@"Read Later" forState:UIControlStateNormal];
                    [readLaterButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [readLaterButton addTarget:self action:@selector(readLater:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell addSubview:readLaterButton];
                }
                break;
			}
		}
	}
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (indexPath.section == SectionHeader) 
    {
        return 20;
	} 
    else 
    {
		if(indexPath.row == SectionDetailSummary)
        {
            return 160;
        }
        else
        {
            return 34;
        }
	}
}
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Memory management
- (void)dealloc {
	[dateString release];
	[summaryString release];
	[item release];
    [super dealloc];
}
@end

