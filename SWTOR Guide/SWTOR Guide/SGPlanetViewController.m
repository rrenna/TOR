//
//  SGPlanetViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGAppDelegate.h"
#import "SGPlanetViewController.h"
#import "SGEntityViewController.h"

@implementation SGPlanetViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGPlanet"];
}
#pragma mark - Class methods
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGPlanetViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [tabView addTabNamed:@"Items" selected:NO];

    //NameLabel.text = [_entity valueForKey:@""] //NOT NEEDED (Name in title)
    AllegianceLabel.text = [_entity valueForKey:@"Allegiance"];
    StatusLabel.text = [_entity valueForKey:@"Status"];
    RegionLabel.text = [_entity valueForKey:@"Region"];
    TerrainLabel.text = [_entity valueForKey:@"Terrain"];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    
    int heightSaved = 0;
     //Remove starting classes table if no classes assigned
    NSSet* startingClasses = [_entity valueForKey:@"startingClasses"];
    if([startingClasses count] == 0)
    {
        heightSaved += tableView.frame.size.height;
        tableView.hidden = YES;
    }
    
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(TerrainLabel);
    moveViewForSavedSpace(StatusLabel, heightSaved);
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(StatusLabel);
    moveViewForSavedSpace(DescriptionLabel, heightSaved);
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    
    resizeContentSizeForSavedSpace(scrollView,heightSaved);
}
#pragma mark - BHTabsViewDelegate methods
- (void)didTapTabNamed:(NSString *)tabName
{
    [super didTapTabNamed:tabName];
    
    if([tabName isEqualToString:@"Items"])
    {
        scrollView.contentSize = datacronView.frame.size;
        [scrollView addSubview:datacronView];
    }
}
#pragma mark - UITableView Delegate & Datasource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == datacronView)
    {
        NSSet* datacrons = [[_entity valueForKey:@"datacrons"] allObjects];
        NSArray* sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES]];
        NSArray* sortedDatacrons = [datacrons sortedArrayUsingDescriptors:sortDescriptors];
        
        id datacron = [sortedDatacrons objectAtIndex:indexPath.row];
        
        SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGDatacron"] alloc] initWithEntity:datacron];
        
        [self.navigationController pushViewController:entityViewController animated:YES];
        [entityViewController release];        
    }
    else
    {
        NSSet* startingClasses = [_entity valueForKey:@"startingClasses"];
        if([startingClasses count] == 0)
        {
        }
        else
        {
            id entity = [[startingClasses allObjects] objectAtIndex:indexPath.row];
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCharacterClass"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == datacronView)
    {
        NSSet* datacrons = [_entity valueForKey:@"datacrons"];
        return [datacrons count];
    }
    else
    {
        NSSet* startingClasses = [_entity valueForKey:@"startingClasses"];
        int startingClassesCount = [startingClasses count];
        //Will display "No starting classes" if none (needs a row)
        return (startingClassesCount == 0) ? 1 : startingClassesCount;
    }
}
#define CELL_HEIGHT 30
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    if(tableView == datacronView)
    {
        NSSet* datacrons = [[_entity valueForKey:@"datacrons"] allObjects];
        
        NSArray* sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES]];
        NSArray* sortedDatacrons = [datacrons sortedArrayUsingDescriptors:sortDescriptors];
        
        id datacron = [sortedDatacrons objectAtIndex:indexPath.row];
        CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
        
        NSString* planetPreviewFilename = [datacron valueForKey:@"PreviewBackgroundFilename"];
        UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.text = [datacron valueForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
        backgroundImageView.image = backgroundImage;
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        backgroundImageView.clipsToBounds = YES;
        cell.backgroundView = backgroundImageView;
        backgroundImageView.alpha = 0.8;
    }
    else
    {
        NSSet* startingClasses = [_entity valueForKey:@"startingClasses"];
        if([startingClasses count] == 0)
        {
            //Return a "No starting classes" row
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"No classes start on this planet.";
        }
        else
        {
            CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
            id startingClass = [[startingClasses allObjects] objectAtIndex:indexPath.row];
            
            NSString* planetPreviewFilename = [startingClass valueForKey:@"PreviewBackgroundFilename"];
            UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
            
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor darkGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.text = [startingClass valueForKey:@"Name"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            
            UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
            backgroundImageView.image = backgroundImage;
            backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
            backgroundImageView.backgroundColor = [UIColor blackColor];
            cell.backgroundView = backgroundImageView;
            backgroundImageView.alpha = 0.8;
        }
    }
 
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if(tableView == datacronView)
    {
        return [self dividerForTitle:@"Datacrons" withIconKey:@"Datacron"];
    }
    else
    {
        return [self dividerForTitle:@"Starting Classes" withIconKey:@"Classes"];
    }
}
@end
