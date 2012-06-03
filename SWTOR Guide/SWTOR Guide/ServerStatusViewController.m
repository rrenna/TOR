//
//  ServerStatusViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 2012-03-06.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "ServerStatusViewController.h"

#define SERVER_STATUS_URL_PATH @"http://www.swtor.com/server-status"

@interface ServerStatusViewController ()
@property (retain) NSMutableDictionary* regions;
@property (retain) NSMutableArray* searchResults;
@end

@implementation ServerStatusViewController
@synthesize regions,searchResults;
-(id)init
{
    self = [self initWithNibName:@"ServerStatusViewController" bundle:nil];
    if(self)
    {
        displaySearchResult = NO;
        self.title = @"Server Status";
        self.regions = [NSMutableDictionary dictionaryWithCapacity:3];//3 Regions
        self.searchResults = [NSMutableArray array];
        [self refresh:nil];
    }
    return self;
}
-(void)dealloc
{
    [doc release];
    [regions release];
    [searchResults release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    //Each item is a div, who's subchildren are (in this order) :
    // a <h3> of the Region name (class = 'serverStatusTitle')
    // a <div> of the sortable attributes (class = 'serverBody serverMenu')
    // one to many server's (class = 'serverBody row odd' pr class = 'serverBody row even')
    NSArray* serverRegionLists = [doc searchWithXPathQuery:@"//div[@class='serverList sortable']"];
    
    //For each region
    for(TFHppleElement* regionElement in serverRegionLists)
    {
        NSString* regionName = nil;
        for(TFHppleElement* child in regionElement.children)
        {
            if([[child objectForKey:@"class"] isEqualToString:@"serverStatusTitle"])
            {
                regionName = [child content];
                [regions removeObjectForKey:regionName];
                [regions setObject:[NSMutableArray array] forKey:regionName];
            }
            else if ([[child objectForKey:@"class"] isEqualToString:@"serverBody row odd"] || [[child objectForKey:@"class"] isEqualToString:@"serverBody row even"])
            {
                NSMutableArray* region = [regions objectForKey:regionName];
                [region addObject:child];
            }
        }
    }
}
#pragma mark - IBActions
-(IBAction)refresh:(id)sender
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:SERVER_STATUS_URL_PATH]];
    doc = [[TFHpple alloc] initWithHTMLData:data];
    [tableView reloadData];
}
#pragma mark - UITableView Datasource & Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //During search mode, the table will only display search results
    if(displaySearchResult) 
    {
        return 1;
    }
    else
    {
        return [regions count];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(displaySearchResult)
    {
        //Return number of search results
        return [searchResults count];
    }
    else 
    {
        NSArray* region = [[regions allValues] objectAtIndex:section];
        return [region count];
    }
}
#define HEIGHT_FOR_HEADER 40
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(displaySearchResult)
    {
        return 0;
    }
    else 
    {
        return HEIGHT_FOR_HEADER;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView* dividerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_FOR_HEADER)] autorelease];
    dividerView.image = [UIImage imageNamed:@"divider.png"];
    dividerView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* dividerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(13, 0, 307, HEIGHT_FOR_HEADER)] autorelease];
    dividerLabel.text = [[regions allKeys] objectAtIndex:section];
    dividerLabel.backgroundColor = [UIColor clearColor];
    dividerLabel.textColor = [UIColor darkGrayColor];
    dividerLabel.shadowColor = [UIColor whiteColor];
    dividerLabel.shadowOffset = CGSizeMake(0,1);
    
    [dividerView addSubview:dividerLabel];
    return dividerView;
}
#define HEIGHT_FOR_ROW 55
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FOR_ROW;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //Switches between a region and an array of search results
    NSArray* datasource = (displaySearchResult) ? searchResults :  [[regions allValues] objectAtIndex:indexPath.section];
    
    TFHppleElement* element = [datasource objectAtIndex:indexPath.row];
    
    NSString* name = [element objectForKey:@"data-name"];
    NSString* status = [element objectForKey:@"data-status"];
    NSString* type = [element objectForKey:@"data-type"];
    NSString* population = [element objectForKey:@"data-population"];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    cell.textLabel.shadowOffset = CGSizeMake(0,1);
    cell.textLabel.shadowColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.text = name;
    
    cell.detailTextLabel.text = type;
    
    UIImageView* populationView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 55)] autorelease];
    cell.accessoryView = populationView;
    
    if([[population lowercaseString] isEqualToString:@"1"])
    {
        populationView.image = [UIImage imageNamed:@"serverPopulationLow.png"];
    }
    else if([[population lowercaseString] isEqualToString:@"2"])
    {
        populationView.image = [UIImage imageNamed:@"serverPopulationMedium.png"];
    }
    else 
    {
        populationView.image = [UIImage imageNamed:@"serverPopulationHigh.png"];
    }
    

    if([[status lowercaseString] isEqualToString:@"up"])
    {
        cell.imageView.image = [UIImage imageNamed:@"upStatus.png"];
    }
    else 
    {
       cell.imageView.image = [UIImage imageNamed:@"downStatus.png"];
    }
    
    return cell;
}
#pragma mark - UISearchBar delegate methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText isEqualToString:@""])
    {
        displaySearchResult = NO;
    }
    else 
    {
        displaySearchResult = YES;
        
        [searchResults removeAllObjects];
        for (NSArray* region in [regions allObjects]) 
        {
            for(TFHppleElement* element in region)
            {
                NSString* serverName = [element objectForKey:@"data-name"];
                NSRange range = [[serverName lowercaseString] rangeOfString:[searchText lowercaseString]];
                if(range.location != NSNotFound)
                {
                    [searchResults addObject:element];
                }
            }
        }
    }
    
    [tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
}
@end
