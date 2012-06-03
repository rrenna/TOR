//
//  SGShipViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-07.
//  Copyright 2011 None. All rights reserved.
//

#import "SGShipViewController.h"
#import "SGAppDelegate.h"

@implementation SGShipViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGShip"];
}
#pragma mark - Class methods
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGShipViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    manufacturerLabel.text = [_entity valueForKey:@"manufacturer"];
    modelLabel.text = [_entity valueForKey:@"model"];
    
    scrollView.contentSize = CGSizeMake(320,manufacturerLabel.frame.size.height + modelLabel.frame.size.height + DescriptionLabel.frame.size.height + tableView.frame.size.height + 30);
    
    int heightSaved = 0;
    heightSaved = resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    resizeContentSizeForSavedSpace(scrollView, heightSaved - 15);
}
#pragma mark - UITableView Delegate & Datasource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCharacter"] alloc] initWithEntity:[_entity valueForKey:@"companion"]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#define CELL_HEIGHT 30
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    id* droid = [_entity valueForKey:@"companion"];
    if(!droid)
    {
        //Return a "No droids" row
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"No droids for this ship.";
    }
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.text = [droid valueForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.backgroundView = [self backgroundViewForEntity:droid];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    return [self dividerForTitle:@"Droid" withIconKey:@"Droids"];
}
@end
