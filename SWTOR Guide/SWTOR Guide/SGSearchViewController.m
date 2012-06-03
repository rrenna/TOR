//
//  SGSearchViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-11.
//  Copyright 2011 None. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGSearchViewController.h"
#import "SGEntityViewController.h"
#import "SGAppDelegate.h"

@interface SGSearchViewController()
@property (retain) NSArray* results;
@end

@implementation SGSearchViewController
@synthesize results;
#pragma mark - View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search";
    }
    return self;
}
-(void)dealloc
{
    [results release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - UITableView Datasource
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}
#define HEIGHT_FOR_ROW 55
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FOR_ROW;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CGRect cellFrame = {0,0,320,50};
    static CGRect labelFrame = {5,5,250,40};
    id result = [[self.results allObjects] objectAtIndex:indexPath.row];
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
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
        titleLabel.shadowOffset = CGSizeMake(0,1);
        titleLabel.shadowColor = [UIColor darkGrayColor];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.text = name;
        [cell.contentView addSubview:titleLabel];
        
        
        UIView* backgroundView = [[[UIView alloc] initWithFrame:cellFrame] autorelease];
        backgroundView.backgroundColor = [UIColor clearColor];
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellFrame] autorelease];
        backgroundImageView.image = backgroundImage;
        backgroundImageView.layer.borderWidth = 1.0;
        backgroundImageView.backgroundColor = colorForEntity(object);
        
        [backgroundView addSubview:backgroundImageView];
        cell.backgroundView = backgroundView;
        
    };
    
    setupPreview(result,cell);
    
    return cell;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSManagedObjectContext* moc = [[SGAppDelegate delegate] managedObjectContext];
    NSFetchRequest* request = [NSFetchRequest new];
    request.entity = [NSEntityDescription entityForName:@"SGEntity" inManagedObjectContext:moc];
    request.predicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@ AND Searchable = TRUE",searchText];
    self.results = [moc executeFetchRequest:request error:nil];
    //results
    [request release];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{   
    id entity = [self.results objectAtIndex:indexPath.row];
    NSString* entityName = [[entity entity] name];
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:entityName] alloc] initWithEntity:entity];
    [self.navigationController pushViewController:entityViewController animated:YES];
    [entityViewController release];
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
