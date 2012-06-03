//
//  OpenSpringBoardVC.m
//  openspringboard
//
//  Created by Mobile Flow LLC on 2/21/11.
//  Copyright 2011 Mobile Flow LLC. All rights reserved.
//

#import "SGMenuViewController.h"
#import "SGEntityListingViewController.h"
#import "SGSearchViewController.h"
#import "ServerStatusViewController.h"
#import "SGNameGeneratorViewController.h"
#import "RootViewController.h"
#import "MDAboutController.h"
#import "MDACMochiDevStyle.h"

@interface SGMenuViewController ()
-(void)viewEntityNamed:(NSString*)entityType withTitle:(NSString*)entityTitle usingPredicate:(NSString*)predicateString;
@end

@implementation SGMenuViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    [menuScrollView addSubview:menuView];
    menuScrollView.contentSize = menuView.frame.size;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    [super dealloc];
}
#pragma mark - IBActions
-(IBAction)search:(id)sender
{
    SGSearchViewController* searchViewController = [[SGSearchViewController alloc] initWithNibName:@"SGSearchViewController" bundle:nil];
    [self.navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
}
-(IBAction)settings:(id)sender
{
    MDAboutController* aboutController = [[[MDAboutController alloc] initWithStyle: [MDACMochiDevStyle style]] autorelease];
    [aboutController removeLastCredit];
    
    [self.navigationController pushViewController:aboutController animated:YES];
}
-(IBAction)news:(id)sender
{
    RootViewController* newsViewController = [[RootViewController alloc] init];
    [self.navigationController pushViewController:newsViewController animated:YES];
    [newsViewController release];
}
-(IBAction)nameGenerator:(id)sender
{
    //Name generator
    [self.navigationController pushViewController:[[SGNameGeneratorViewController new] autorelease] animated:YES];
}
-(IBAction)classes:(id)sender
{
    //Classes
    [self viewEntityNamed:@"SGCharacterClass" withTitle:@"Classes" usingPredicate:@"SELF.isAdvancedClass == NO"];
}
-(IBAction)crewSkills:(id)sender
{
    //Crafting
    [self viewEntityNamed:@"SGCraftingSkill" withTitle:@"Crew Skills" usingPredicate:nil];
}
-(IBAction)planets:(id)sender
{
    //Planets
    [self viewEntityNamed:@"SGPlanet" withTitle:@"Planets" usingPredicate:@"SELF.Allegiance MATCHES '^[a-zA-Z].*'"];
}
-(IBAction)warzones:(id)sender
{
    [self viewEntityNamed:@"SGWarzone" withTitle:@"Warzones" usingPredicate:nil];
}
-(IBAction)starships:(id)sender
{
    [self viewEntityNamed:@"SGShip" withTitle:@"Starships" usingPredicate:nil];
}
-(IBAction)operations:(id)sender
{
    [self viewEntityNamed:@"SGOperation" withTitle:@"Operations" usingPredicate:nil];
}
-(IBAction)flashpoints:(id)sender
{
    [self viewEntityNamed:@"SGFlashpoint" withTitle:@"Flashpoints" usingPredicate:nil];
}
-(IBAction)datacrons:(id)sender
{
    [self viewEntityNamed:@"SGDatacron" withTitle:@"Datacrons" usingPredicate:nil];
}
-(IBAction)serverStatus:(id)sender
{
    //Server Status
    [self.navigationController pushViewController:[[ServerStatusViewController new] autorelease] animated:YES];
}
#pragma mark - Private methods
-(void)viewEntityNamed:(NSString*)entityType withTitle:(NSString*)entityTitle usingPredicate:(NSString*)predicateString
{
    SGEntityListingViewController* entityListingViewController = [[SGEntityListingViewController alloc] initWithEntityName:entityType andTitle:entityTitle];
    entityListingViewController.entityPredicateString = predicateString;
    [self.navigationController pushViewController:entityListingViewController animated:YES];
    [entityListingViewController release];
}
#pragma mark - UIScrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x >= 160)
    {
        [pageControl setCurrentPage:1];
    }
    else
    {
        [pageControl setCurrentPage:0];
    }
}
@end
