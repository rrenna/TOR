//
//  SGWarzoneViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-08.
//  Copyright 2011 None. All rights reserved.
//

#import "SGWarzoneViewController.h"
#import "SGAppDelegate.h"

@implementation SGWarzoneViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGWarzone"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGWarzoneViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber* isFactionSeperated = [_entity valueForKey:@"isFactionSeperated"];

    AllegianceLabel.text = ([isFactionSeperated boolValue]) ? @"Split by Faction" : @"Mixed Factions"; 
    TerrainLabel.text = [_entity valueForKey:@"Terrain"];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    int heightSaved = 0;
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);    
    resizeContentSizeForSavedSpace(scrollView,heightSaved);
}
#pragma mark - UITableView Delegate & Datasource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject* location = [_entity valueForKey:@"location"];
    
    if(location && [[[location entity] name] isEqualToString:@"SGPlanet"])
    {
        SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGPlanet"] alloc] initWithEntity:location];
        [self.navigationController pushViewController:entityViewController animated:YES];
        [entityViewController release];
    }
    
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
    id location = [_entity valueForKey:@"location"];
    if(!location)
    {
        //Return a "No starting classes" row
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"Error - Please report!";
    }
    else
    {
        CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
        
        NSString* planetPreviewFilename = [location valueForKey:@"PreviewBackgroundFilename"];
        UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.text = [location valueForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        //UIView* backgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        //backgroundView.backgroundColor = [UIColor clearColor];
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
        backgroundImageView.image = backgroundImage;
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImageView.backgroundColor = [UIColor blackColor];
        
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        backgroundImageView.clipsToBounds = YES;
        cell.backgroundView = backgroundImageView;
        backgroundImageView.alpha = 0.8;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{    
    return [self dividerForTitle:@"Location" withIconKey:@"Locations"];
}
@end
