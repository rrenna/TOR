//
//  SGCharacterClassViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-04.
//  Copyright 2011 None. All rights reserved.
//

#import "SGCharacterClassViewController.h"
#import "SGAppDelegate.h"
#import "SGCraftingSkillViewController.h"
#import "BHTabView.h"
#import "BHTabStyle.h"

@implementation SGCharacterClassViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGCharacterClass"];
}
#pragma mark - Class methods
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGCharacterClassViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup Tabbar
    [tabView addTabNamed:@"Crew" selected:NO];
    [tabView addTabNamed:@"Skills" selected:NO];

    
    //Setup Overview Content
    AllegianceLabel.text = [_entity valueForKey:@"Allegiance"];
    HeadlineLabel.text = [_entity valueForKey:@"Headline"];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    //Setup Progression Content
    //Shared skill tree
    id sharedTrees = [[_entity valueForKey:@"skillTrees"] allObjects];
    sharedSkillTreeLabel.text = [[sharedTrees objectAtIndex:0] valueForKey:@"Name"];
    sharedSkillTreeDescriptionLabel.text = [[sharedTrees objectAtIndex:0] valueForKey:@"Description"];
    
    NSArray* advancedClasses = [[_entity valueForKey:@"advancedClasses"] allObjects];
    id advancedClassA = [advancedClasses objectAtIndex:0];
    id advancedClassASkillTrees = [[advancedClassA valueForKey:@"skillTrees"] allObjects];
    id advancedClassB = [advancedClasses objectAtIndex:1];
    id advancedClassBSkillTrees = [[advancedClassB valueForKey:@"skillTrees"] allObjects];
    
    advancedClassALabel.text = [advancedClassA valueForKey:@"Name"];
    advancedClassADescriptionLabel.text = [advancedClassA valueForKey:@"Headline"];
    resizeLabelToTopAlignmentReturningHeightReduced(advancedClassADescriptionLabel);
    
    advancedSkillTreeALabel.text = [[advancedClassASkillTrees objectAtIndex:0] valueForKey:@"Name"];
    advancedSkillTreeADescriptionLabel.text = [[advancedClassASkillTrees objectAtIndex:0] valueForKey:@"Description"];
    advancedSkillTreeBLabel.text = [[advancedClassASkillTrees objectAtIndex:1] valueForKey:@"Name"];
    advancedSkillTreeBDescriptionLabel.text = [[advancedClassASkillTrees objectAtIndex:1] valueForKey:@"Description"];
    
    advancedClassBLabel.text = [advancedClassB valueForKey:@"Name"];
    advancedClassBDescriptionLabel.text = [advancedClassB valueForKey:@"Headline"];
    resizeLabelToTopAlignmentReturningHeightReduced(advancedClassBDescriptionLabel);
    
    advancedSkillTreeCLabel.text = [[advancedClassBSkillTrees objectAtIndex:0] valueForKey:@"Name"];
    advancedSkillTreeCDescriptionLabel.text = [[advancedClassBSkillTrees objectAtIndex:0] valueForKey:@"Description"];
    advancedSkillTreeDLabel.text = [[advancedClassBSkillTrees objectAtIndex:1] valueForKey:@"Name"];
    advancedSkillTreeDDescriptionLabel.text = [[advancedClassBSkillTrees objectAtIndex:1] valueForKey:@"Description"];
    
    /*
     IBOutlet UILabel* sharedSkillTreeLabel;
     IBOutlet UILabel* sharedSkillTreeDescriptionLabel;
     IBOutlet UILabel* advancedClassALabel;
     IBOutlet UILabel* advancedClassADesscriptionLabel;
     IBOutlet UILabel* advancedSkillTreeALabel;
     IBOutlet UILabel* advancedSkillTreeBLabel;
     IBOutlet UILabel* advancedSkillTreeADescriptionLabel;
     IBOutlet UILabel* advancedSkillTreeBDescriptionLabel;
     */
    
    
    int heightSaved = 0;
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(HeadlineLabel);
    moveViewForSavedSpace(DescriptionLabel, heightSaved);
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    resizeViewForSavedSpace(contentView, heightSaved);
    
    resizeContentSizeForSavedSpace(scrollView,heightSaved);
}
-(NSString*)htmlSummaryOfEntity
{
    NSString* summaryOfClass = [NSString stringWithFormat:@"</br><br/><table><tr><td>Allegiance</td><td><b>%@</b></td></tr><tr><td>Starting Planet</td><td><b>%@</b></td></tr></table>",[_entity valueForKey:@"Allegiance"],[[_entity valueForKey:@"startingPlanet"] Name]];
    return [NSString stringWithFormat:@"%@%@",summaryOfClass,[super htmlSummaryOfEntity]];
}
#pragma mark - IBActions
-(IBAction)sharedSkillTreeClick:(id)sender
{
    id sharedTrees = [[_entity valueForKey:@"skillTrees"] allObjects];    
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGSkillTree"] alloc] initWithEntity:[sharedTrees objectAtIndex:0]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];

}
-(IBAction)advancedSkillTreeAClick:(id)sender
{
    NSArray* advancedClasses = [[_entity valueForKey:@"advancedClasses"] allObjects];
    id advancedClassA = [advancedClasses objectAtIndex:0];
    NSArray* skillTrees = [[advancedClassA valueForKey:@"skillTrees"] allObjects];
    
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGSkillTree"] alloc] initWithEntity:[skillTrees objectAtIndex:0]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];

}
-(IBAction)advancedSkillTreeBClick:(id)sender
{
    NSArray* advancedClasses = [[_entity valueForKey:@"advancedClasses"] allObjects];
    id advancedClassA = [advancedClasses objectAtIndex:0];
    NSArray* skillTrees = [[advancedClassA valueForKey:@"skillTrees"] allObjects];
    
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGSkillTree"] alloc] initWithEntity:[skillTrees objectAtIndex:1]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];
}
-(IBAction)advancedSkillTreeCClick:(id)sender
{
    NSArray* advancedClasses = [[_entity valueForKey:@"advancedClasses"] allObjects];
    id advancedClassB = [advancedClasses objectAtIndex:1];
    NSArray* skillTrees = [[advancedClassB valueForKey:@"skillTrees"] allObjects];
    
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGSkillTree"] alloc] initWithEntity:[skillTrees objectAtIndex:0]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];
}
-(IBAction)advancedSkillTreeDClick:(id)sender
{
    NSArray* advancedClasses = [[_entity valueForKey:@"advancedClasses"] allObjects];
    id advancedClassB = [advancedClasses objectAtIndex:1];
    NSArray* skillTrees = [[advancedClassB valueForKey:@"skillTrees"] allObjects];
    
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGSkillTree"] alloc] initWithEntity:[skillTrees objectAtIndex:1]];
    
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];
}
#pragma mark - BHTabsView delegate methods
- (void)didTapTabNamed:(NSString *)tabName
{
    [super didTapTabNamed:tabName];
    
    if([tabName isEqualToString:@"Crew"])
    {
        scrollView.contentSize = crewView.frame.size;
        [scrollView addSubview:crewView];
    }
    else if([tabName isEqualToString:@"Skills"])
    {
        scrollView.contentSize = progressionView.frame.size;
        [scrollView addSubview:progressionView];
    }
}
#pragma mark - UITableView Delegate & Datasource methods
#define CELL_HEIGHT 30
#define TAG_STARSHIP_TABLE 0
#define TAG_STARTING_PLANET_TABLE 1
#define TAG_COMPANIONS_TABLE 2
#define TAG_RACES_LEFT_TABLE 3
#define TAG_RACES_RIGHT_TABLE 4
#define TAG_CREW_SKILLS_TABLE 5

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        id entity = [_entity valueForKey:@"startingPlanet"];
        if(entity)
        {
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGPlanet"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }

    }
    else if(tableView.tag == TAG_STARSHIP_TABLE)
    {
        id entity = [_entity valueForKey:@"ship"];
        if(entity)
        {
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGShip"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    else if(tableView.tag == TAG_COMPANIONS_TABLE)
    {
        NSArray* companions = [[_entity valueForKey:@"companions"] sortedArrayUsingComparator:^NSComparisonResult
           (id obj1, id obj2) 
           {
               NSNumber* companionOrder1 = [obj1 valueForKey:@"order"];
               NSNumber* companionOrder2 = [obj2 valueForKey:@"order"];
               
               if([companionOrder1 intValue] < [companionOrder2 intValue])
               {
                   return NSOrderedAscending;
               }
               else
               {
                   return NSOrderedDescending;
               }
           }];
        
        
        id entity = [companions objectAtIndex:indexPath.row];
        if(entity)
        {
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCharacter"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    else if(tableView.tag == TAG_CREW_SKILLS_TABLE)
    {
        NSArray* crewSkills = [[_entity valueForKey:@"craftingSkills"] allObjects];
        id entity = [crewSkills objectAtIndex:indexPath.row];
        if(entity)
        {
            SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGCraftingSkill"] alloc] initWithEntity:entity];
            
            [self.navigationController pushViewController:entityViewController animated:YES];
            [entityViewController release];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == TAG_STARSHIP_TABLE)
    {
        return 1; //Starships
    }
    else if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        return 1; //Starting Planet
    }
    else if(tableView.tag == TAG_COMPANIONS_TABLE)
    {
        return 5; //Companions
    }
    else if(tableView.tag == TAG_CREW_SKILLS_TABLE)
    {
        return [[_entity valueForKey:@"craftingSkills"] count]; //Companions
    }
    else
    {
        id playableRaces = [_entity valueForKey:@"races"];
        int remainder = [playableRaces count] % 2;
        int rows = ([playableRaces count] / 2) + remainder;
        return rows; //Playable Races
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    if(tableView.tag == TAG_STARSHIP_TABLE)
    {
        id ships = [_entity valueForKey:@"ship"];
        if(!ships)
        {
            //Return a "No starting classes" row
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Error - Please report.";
        }
        else
        {
            CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
            
            NSString* planetPreviewFilename = [ships valueForKey:@"PreviewBackgroundFilename"];
            UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor darkGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.text = [ships valueForKey:@"Name"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            
            UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
            backgroundImageView.image = backgroundImage;
            backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
            backgroundImageView.backgroundColor = [UIColor blackColor];
            cell.backgroundView = backgroundImageView;
            backgroundImageView.alpha = 0.8;
            
        }
    }
    else if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        id planet = [_entity valueForKey:@"startingPlanet"];
        CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
        
        NSString* planetPreviewFilename = [planet valueForKey:@"PreviewBackgroundFilename"];
        UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        cell.textLabel.text = [planet valueForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
        backgroundImageView.image = backgroundImage;
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImageView.backgroundColor = [UIColor blackColor];
    
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        backgroundImageView.clipsToBounds = YES;
        cell.backgroundView = backgroundImageView;
        backgroundImageView.alpha = 0.8;

    }
    else if(tableView.tag == TAG_COMPANIONS_TABLE)
    {
        //Companions
        NSArray* companions = [[_entity valueForKey:@"companions"] sortedArrayUsingComparator:^NSComparisonResult
        (id obj1, id obj2) 
        {
            NSNumber* companionOrder1 = [obj1 valueForKey:@"order"];
            NSNumber* companionOrder2 = [obj2 valueForKey:@"order"];
            
            if([companionOrder1 intValue] < [companionOrder2 intValue])
            {
                return NSOrderedAscending;
            }
            else
            {
                return NSOrderedDescending;
            }
        }];
        if([companions count] == 0)
        {
            //Return a "No starting classes" row
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Error - Please report.";
        }
        else
        {
            id companion = [[companions allObjects] objectAtIndex:indexPath.row];
            NSString* name = [companion valueForKey:@"Name"];
            CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
            
            NSString* planetPreviewFilename = [companion valueForKey:@"PreviewBackgroundFilename"];
            UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor darkGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.text = [companion valueForKey:@"Name"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.backgroundView = [self backgroundViewForEntity:companion];
            
        }
    }
    else if(tableView.tag == TAG_CREW_SKILLS_TABLE)
    {
        //Crew Skills
        NSArray* crewSkills = [_entity valueForKey:@"craftingSkills"];
        if([crewSkills count] == 0)
        {
            //Return a "No starting classes" row
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = @"Error - Please report.";
        }
        else
        {
            id crewSkill = [[crewSkills allObjects] objectAtIndex:indexPath.row];
            NSString* name = [crewSkill valueForKey:@"Name"];
            CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
            
            NSString* planetPreviewFilename = [crewSkill valueForKey:@"PreviewBackgroundFilename"];
            UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
            cell.textLabel.shadowOffset = CGSizeMake(0,1);
            cell.textLabel.shadowColor = [UIColor darkGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.textLabel.text = [crewSkill valueForKey:@"Name"];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.backgroundView = [self backgroundViewForEntity:crewSkill];
        }
    }
    else //Races
    {
        int index;
        if(tableView.tag == TAG_RACES_LEFT_TABLE) //Will display even numbers
        {
            index = indexPath.row * 2;
        }
        else
        {
            index = (indexPath.row * 2) + 1;
        }
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        cell.textLabel.shadowOffset = CGSizeMake(0,1);
        cell.textLabel.shadowColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        id playableRaces = [_entity valueForKey:@"races"];
        if([[playableRaces allObjects] count] > index)
        {
            id race =  [[playableRaces allObjects] objectAtIndex:index]; //Playable Races
            cell.textLabel.text = [race valueForKey:@"Name"];
            NSString* raceIconName = [NSString stringWithFormat:@"icon_%@",[[[race valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]];
            [cell.imageView setImage:[UIImage imageNamed:raceIconName]];
        }

    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == TAG_STARSHIP_TABLE || tableView.tag == TAG_COMPANIONS_TABLE || tableView.tag == TAG_STARTING_PLANET_TABLE || tableView.tag == TAG_CREW_SKILLS_TABLE)
    {
        return HEIGHT_FOR_DIVIDER;
    }
    else
    {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        return HEIGHT_FOR_DIVIDER;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        return  [self dividerForTitle:@"Races" withIconKey:@"Races"];
    }
    else
    {
        return nil;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* header = nil;
    if(tableView.tag == TAG_STARSHIP_TABLE)
    {
        header = [self dividerForTitle:@"Starship" withIconKey:@"Starships"];
    }
    else if(tableView.tag == TAG_COMPANIONS_TABLE)
    {
        header = [self dividerForTitle:@"Companions" withIconKey:@"Companions"];
    }
    else if(tableView.tag == TAG_STARTING_PLANET_TABLE)
    {
        header = [self dividerForTitle:@"Starting Planet" withIconKey:@"Planets"];
    }
    else if(tableView.tag == TAG_CREW_SKILLS_TABLE)
    {
        header = [self dividerForTitle:@"Crafting Skills" withIconKey:@"Skills"];
    }
    else
    {
        header = [self dividerForTitle:nil withIconKey:nil];
    }
    return header;
}
@end
