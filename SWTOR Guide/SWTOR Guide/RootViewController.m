//
//  RootViewController.m
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

#import "RootViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailTableViewController.h"
#import "TSMiniWebBrowser.h"

@implementation RootViewController
@synthesize itemsToDisplay;

#pragma mark View lifecycle
#define LAST_VIEWED_FEED_URL_KEY @"LAST_VIEWED_FEED_URL"
- (void)viewDidLoad 
{
	// Super
	[super viewDidLoad];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"Background"];
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    
	// Setup
	self.title = @"Loading...";
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundView = backgroundImageView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
	
	// Refresh button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks 
																							target:self 
																							action:@selector(changeDatasource)] autorelease];
    
    //Add pull to reload
    if (refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height) arrowImageName:@"whiteArrow" textColor:[UIColor whiteColor]];


        
        view.backgroundColor = [UIColor clearColor];
		view.delegate = self;
		[self.tableView addSubview:view];
		refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[refreshHeaderView refreshLastUpdatedDate];
    
	// Parse
    NSString* lastViewedFeedURLString = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_VIEWED_FEED_URL_KEY];
    NSString* URLString = (lastViewedFeedURLString) ? lastViewedFeedURLString : @"feed://www.swtor.com/feed/news/article";
    
	NSURL *feedURL = [NSURL URLWithString:URLString];
	feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
    
}
- (void)dealloc 
{
    feedParser.delegate = nil;
    //
	[formatter release];
	[parsedItems release];
	[itemsToDisplay release];
	[feedParser release];
    [super dealloc];
}
#pragma mark Parsing

// Reset and reparse
- (void)refresh 
{
	self.title = @"Refreshing...";
	[parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
	self.tableView.userInteractionEnabled = NO;
}
#define swtorCOM @"swtor.com"
//#define tentonhammerCOM @"swtor.tentonhammer.com"
#define darthhaterCOM @"darthhater.com"
#define alterswtorCOM @"alterswtor.com"
#define swtorlifeCOM @"swtor-life.com"
#define torwarsCOM @"torwars.com"
#define torocastCOM @"torocast.com"

- (void) changeDatasource
{
    UIActionSheet* shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"T.O.R. News Sources" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:swtorCOM,torocastCOM,darthhaterCOM,swtorlifeCOM,torwarsCOM, nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [shareActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}
- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];	
}
#pragma mark - UIActionsheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSURL* url;
    
    if([title isEqualToString:swtorCOM])
    {
        url = [NSURL URLWithString:@"feed://www.swtor.com/feed/news/article"];
    }
    else if([title isEqualToString:alterswtorCOM])
    {
        url = [NSURL URLWithString:@"feed://www.alterswtor.com/feed"];
    }
    else if ([title isEqualToString:swtorlifeCOM])
    {
        url = [NSURL URLWithString:@"feed://www.swtor-life.com/feed/"];
    }
    else if ([title isEqualToString:torwarsCOM])
    {
        url = [NSURL URLWithString:@"feed://torwars.com/feed/"];
    }
    else if ([title isEqualToString:darthhaterCOM])
    {
        url = [NSURL URLWithString:@"feed://darthhater.com/feed/"];
    }
    //NO LONGER EXISTS
    /*else if([title isEqualToString:tentonhammerCOM])
    {
        url = [NSURL URLWithString:@"feed://swtor.tentonhammer.com/feed/"];
    }*/
    else if([title isEqualToString:torocastCOM])
    {
        url = [NSURL URLWithString:@"feed://www.torocast.com/index.php/home?format=feed"];
    }
    else
    {
        //They cancelled the prompt
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[url absoluteString] forKey:LAST_VIEWED_FEED_URL_KEY];
    
    [feedParser release];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	//[feedParser parse];
    
    [self refresh];

}
#pragma mark - MWFeedParser delegate methods

- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = @"T.O.R. News"; //info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) [parsedItems addObject:item];	
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
	self.title = @"Failed";
	self.itemsToDisplay = [NSArray array];
	[parsedItems removeAllObjects];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}
#pragma mark Table view delegate & data source
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
	// Configure the cell.
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
	if (item) {
		
		// Process
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
		
		// Set
		cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        
		cell.textLabel.text = itemTitle;
		NSMutableString *subtitle = [NSMutableString string];
		if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
		[subtitle appendString:itemSummary];
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
		cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        cell.detailTextLabel.text = subtitle;
        cell.detailTextLabel.numberOfLines = 2;
		
	}
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// Show detail
    MWFeedItem* item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
    TSMiniWebBrowser* browser = [[[TSMiniWebBrowser alloc] initWithItem:item] autorelease];
    
	[self.navigationController pushViewController:browser animated:YES];
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{		
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self refresh];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}
@end
