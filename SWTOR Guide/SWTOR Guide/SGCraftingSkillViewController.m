//
//  SGCraftingSkill.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-12.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGCraftingSkillViewController.h"
#import "SGAppDelegate.h"

@implementation SGCraftingSkillViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGCraftingSkill"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGCraftingSkillViewController"];
    if(self)
    {
        isCrafting = [[_entity valueForKey:@"Type"] isEqualToString:@"Crafting"];
        //Customize for content
        //numberOfSections = (isCrafting) ? 4 : 3; //If not a crafting skill, it's avaliable to all (companions)
        //avaliableToClassIndex  = (isCrafting) ? 0 : -1; //Will be zero if needed
        //relianceIndex  = (isCrafting) ? 1 : 0;
        //headlineIndex = (isCrafting) ? 2 : 1;
        //descriptionIndex = (isCrafting) ? 3 : 2;
        numberOfSections = 3; //If not a crafting skill, it's avaliable to all (companions)
        avaliableToClassIndex  = -1; //Will be zero if needed
        relianceIndex  =  0;
        headlineIndex =  1;
        descriptionIndex = 2;
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NameLabel.text = [_entity valueForKey:@""] //NOT NEEDED (Name in title)
    TypeLabel.text = [_entity valueForKey:@"Type"];
    ProducesLabel.text = [_entity valueForKey:@"Result"];
    
    resizeLabelToTopAlignmentReturningHeightReduced(ProducesLabel);
    
    
    //DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    //int heightSaved = 0;
    //heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(TypeLabel);
    //moveViewForSavedSpace(TypeLabel, heightSaved);
    //heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(ProducesLabel);
    //moveViewForSavedSpace(ProducesLabel, heightSaved);
    //heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    
    //resizeContentSizeForSavedSpace(scrollView,heightSaved);
}
#pragma mark - UITableView Delegate & Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberOfSections;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSSet* datasource = nil;
    if(indexPath.section == avaliableToClassIndex)
    {
        datasource = [_entity valueForKey:@"characterClasses"];
        
        if(![datasource count] == 0)
        {
            id entity = [[datasource allObjects] objectAtIndex:indexPath.row];
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCharacterClass"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    else if(indexPath.section == relianceIndex)
    {
        if(isCrafting) //Crew skills relied upon
        {
            datasource = [_entity valueForKey:@"reliesOn"];
        }
        else
        {
            datasource = [_entity valueForKey:@"reliedOnBy"];
        }
        
        if(![datasource count] == 0)
        {
            id entity = [[datasource allObjects] objectAtIndex:indexPath.row];
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCraftingSkill"] alloc] initWithEntity:entity];
        
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSSet* datasource = nil;
    if(section == avaliableToClassIndex)
    {
        datasource = [_entity valueForKey:@"characterClasses"];
    }
    else if(section == relianceIndex)
    {
        if(isCrafting) //Crew skills relied upon
        {
            datasource = [_entity valueForKey:@"reliesOn"];
        }
        else
        {
            datasource = [_entity valueForKey:@"reliedOnBy"];
        }
    }
    else
    {
        return 1; //Description
    }
    
    int count = [datasource count];
    //Will display "No starting classes" if none (needs a row)
    return (count == 0) ? 1 : count;
}
#define CELL_HEIGHT 30
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == headlineIndex)
    {
        return [[_entity valueForKey:@"Headline"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:13] constrainedToSize:CGSizeMake(275, 900) lineBreakMode:UILineBreakModeWordWrap].height;
    }
    else if(indexPath.section == descriptionIndex)
    {
        NSString* description = [_entity valueForKey:@"Description"];
        int height = [description sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:13] constrainedToSize:CGSizeMake(275, 900) lineBreakMode:UILineBreakModeWordWrap].height;
        return height;
    }
    
    return CELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == headlineIndex)
    {
        return 15;
    }
    else if(section == descriptionIndex)
    {
        return 10;
    }
    else
    {
        return [super tableView:tableView heightForHeaderInSection:section];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    NSSet* datasource = nil;
    
    if(indexPath.section == avaliableToClassIndex)
    {
        datasource = [_entity valueForKey:@"characterClasses"];
    }
    else if (indexPath.section == relianceIndex)
    {
        if(isCrafting) //Crew skills relied upon
        {
            datasource = [_entity valueForKey:@"reliesOn"];
        }
        else
        {
            datasource = [_entity valueForKey:@"reliedOnBy"];
        }
    }
    else if(indexPath.section == headlineIndex)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textColor = [UIColor colorWithWhite:0.93 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13]; //Don't make the headline bold until we have a description + headline
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [_entity valueForKey:@"Headline"];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    else if(indexPath.section == descriptionIndex)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textColor = [UIColor colorWithWhite:0.93 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.numberOfLines = 0;
        //cell.textLabel.shadowOffset = CGSizeMake(0,-1);
        //cell.textLabel.shadowColor = [UIColor blackColor];
        //cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = [_entity valueForKey:@"Description"];
        
        return cell;
    }
    
    if([datasource count] == 0)
    {
        //Return a "No starting classes" row
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"Not avaliable.";
    }
    else
    {
        CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
        id object = [[datasource allObjects] objectAtIndex:indexPath.row];
        
        NSString* planetPreviewFilename = [object valueForKey:@"PreviewBackgroundFilename"];
        UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.text = [object valueForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundView = [self backgroundViewForEntity:object];
    }
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if(section == avaliableToClassIndex)
    {
        return [self dividerForTitle:@"Avaliable to Classes" withIconKey:@"Classes"];
    }
    else if(section == relianceIndex)
    {
        if(isCrafting)
        {
            return [self dividerForTitle:@"Relies On" withIconKey:@"Classes"];
        }
        else
        {
            return [self dividerForTitle:@"Relied Upon By" withIconKey:@"Classes"];
        }
    }
    else
    {
        //Return an empty (but non-nil) UIView object, we want an empty space instead of a default header
        return [[[UIView alloc] init] autorelease];
    }
}
@end
