//
//  SGEntityListingViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-02.
//  Copyright 2011 None. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGAppDelegate.h"
#import "SGEntityListingViewController.h"
#import "SGPlanetViewController.h"

@interface  SGEntityListingViewController()
@property (retain) NSString* entityName;
@property (retain) NSString* sortName;
-(void)getData;
-(void)sortToolbarDisplay;
@end

static CGRect tableFrameMaximized = {0,0,320,460};
static CGRect tableFrameMinimized = {0,0,320,416};
static CGRect sortToolbarFrameMaximized = {0,416,320,44};
static CGRect sortToolbarFrameMinimized = {0,460,320,44};

@implementation SGEntityListingViewController
@synthesize entityName;
@synthesize sortName;
@synthesize entityPredicateString;

#pragma mark - View lifecycle
-(id)initWithEntityName:(NSString*)_entityName
{
    return [self initWithEntityName:_entityName andTitle:_entityName];
}
-(id)initWithEntityName:(NSString*)_entityName andTitle:(NSString*)title
{
    self = [super initWithNibName:@"SGEntityListingViewController" bundle:nil];
    if(self)
    {
        self.entityName = _entityName;
        self.title = title;
        
        entities = [[NSMutableDictionary alloc] init];
    }
    return self;

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    moc = [[SGAppDelegate delegate] managedObjectContext];
    
    [self getData]; //Get initial data
    
    [self sortToolbarDisplay];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [entities release];
    
    [sortName release];
    [entityName release];
    [entityPredicateString release];
    [super dealloc];
}
#define UNSORTED_KEY @"~UNSORTED~"
#pragma mark - Private methods
-(void)getData
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Asks core data to prefetch the Stations relationship
    //NSArray * fetchedRelationshipArray = [[NSArray alloc] initWithObjects:@"Cameras",nil];
    //[fetchRequest setRelationshipKeyPathsForPrefetching:fetchedRelationshipArray];
    
    //Will always sort alphabetically
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES]];
    
    if(self.sortName)
    {
        NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:self.sortName ascending:YES];
        //Insert any selected sort order, place sort description infront of "Name" descriptor
        [sortDescriptors insertObject:sortDescriptor atIndex:0];
    }
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    //@"SELF beginswith '-'"
    if(entityPredicateString)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:entityPredicateString];  
        fetchedObjects = [fetchedObjects filteredArrayUsingPredicate:predicate]; 
    }
    
    //Populate sorted entities
    
    //Clear previous entities
    [entities removeAllObjects];
    if(!self.sortName) //If we are simply sorting alphabetically
    {
        [entities setValue:fetchedObjects forKey:UNSORTED_KEY];
    }
    else
    {
        NSString* keyForLastSortName = nil;
        NSString* keyForSortName = nil;
        
        for ( id entity in fetchedObjects)
        {
            keyForSortName = [entity valueForKey:self.sortName];
            
            //If the two keys are not equal, create a new section
            if(![keyForSortName isEqualToString:keyForLastSortName])
            {
                NSMutableArray* entitiesForSortSection = [NSMutableArray arrayWithObject:entity];
                [entities setValue:entitiesForSortSection forKey:keyForSortName];
            }
            else
            {
                NSMutableArray* entitiesForSortSection = [entities objectForKey:keyForSortName];
                [entitiesForSortSection addObject:entity];
            }
            
            keyForLastSortName = [entity valueForKey:self.sortName];
        }
    }
    
    [fetchRequest release];
}
-(void)sortToolbarDisplay
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    
    if([[entity attributesByName] objectForKey:@"Allegiance"])
    {
        tableView.frame = tableFrameMinimized;
        sortToolbar.frame = sortToolbarFrameMaximized;
        
        [sortSegmentedControl setTitle:@"Allegiance" forSegmentAtIndex:1];
    }
    else if ([[entity attributesByName] objectForKey:@"Type"])
    {
        tableView.frame = tableFrameMinimized;
        sortToolbar.frame = sortToolbarFrameMaximized;
        
        [sortSegmentedControl setTitle:@"Type" forSegmentAtIndex:1];
    }
    else
    {
        tableView.frame = tableFrameMaximized;
        sortToolbar.frame = sortToolbarFrameMinimized;
    }
}
#pragma mark - IBActions
-(IBAction)changeSortedBy:(id)sender
{
    UISegmentedControl* sortingControl = (UISegmentedControl*)sender;
    NSString* selectedSortingOptionName = [sortingControl titleForSegmentAtIndex:sortingControl.selectedSegmentIndex];
    if([selectedSortingOptionName isEqualToString:@"Alphabetically"])
    {
        self.sortName = nil; //Default sort, alphabetically
    }
    else
    {
        self.sortName = selectedSortingOptionName;
    }
    
    [self getData];
    [tableView reloadData];
    
}
#pragma mark - UITableView datasource and delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[entities allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [[entities allKeys] objectAtIndex:section];
    NSArray* data = [entities objectForKey:key];
    
    return [data count];
}
#define HEIGHT_FOR_ROW 55
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FOR_ROW;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView* backgroundImageView = [[cell.backgroundView subviews] objectAtIndex:0];
    backgroundImageView.alpha = 1.0;
    */
    
    id key = [[entities allKeys] objectAtIndex:indexPath.section];
    NSArray* data = [entities objectForKey:key];
    id object = [data objectAtIndex:indexPath.row];

    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:entityName] alloc] initWithEntity:object];
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#define HEIGHT_FOR_HEADER 40
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([entities count] == 1)
    {
        return 0;
        //No title provided if there are no other sections
    }
    else
    {
        return HEIGHT_FOR_HEADER;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([entities count] == 1)
    {
        return nil;
        //No title provided if there are no other sections
    }
    
    UIImageView* dividerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_FOR_HEADER)] autorelease];
    dividerView.image = [UIImage imageNamed:@"divider.png"];
    dividerView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel* dividerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(13, 0, 307, HEIGHT_FOR_HEADER)] autorelease];
    dividerLabel.text = [[entities allKeys] objectAtIndex:section];
    dividerLabel.backgroundColor = [UIColor clearColor];
    dividerLabel.textColor = [UIColor darkGrayColor];
    dividerLabel.shadowColor = [UIColor whiteColor];
    dividerLabel.shadowOffset = CGSizeMake(0,1);
    
    [dividerView addSubview:dividerLabel];
    return dividerView;
}
#define UNSELECTED_BACKGROUND_ALPHA 1.0
/*- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView* backgroundImageView = [[cell.backgroundView subviews] objectAtIndex:0];
    backgroundImageView.alpha = UNSELECTED_BACKGROUND_ALPHA;
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    static CGRect cellFrame = {0,0,320,50};
    static CGRect labelFrame = {5,5,250,40};
    
    id key = [[entities allKeys] objectAtIndex:indexPath.section];
    NSArray* data = [entities objectForKey:key];
    id object = [data objectAtIndex:indexPath.row];
    
    void(^setupPreview)(id,UITableViewCell*) = ^(id object,UITableViewCell* cell) 
    {
        NSString* name = [object valueForKey:@"Name"];
        NSString* entityPreviewFilename = [object valueForKey:@"PreviewBackgroundFilename"];
        UIImage* backgroundImage = [UIImage imageNamed:entityPreviewFilename];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UILabel* titleLabel = [[[UILabel alloc] initWithFrame:labelFrame] autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:24];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.minimumFontSize = 18;
        titleLabel.shadowOffset = CGSizeMake(0,1);
        titleLabel.shadowColor = [UIColor darkGrayColor];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.text = name;
        [cell.contentView addSubview:titleLabel];
        
                
        UIView* backgroundView = [[[UIView alloc] initWithFrame:cellFrame] autorelease];
        backgroundView.backgroundColor = [UIColor clearColor];
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellFrame] autorelease];
        backgroundImageView.image = backgroundImage;
        backgroundImageView.alpha = 0.8;
        backgroundImageView.layer.borderWidth = 1.0;
        backgroundImageView.backgroundColor = colorForEntity(object);

        [backgroundView addSubview:backgroundImageView];
        cell.backgroundView = backgroundView;

    };
    
    setupPreview(object,cell);
    return cell;
}

@end
