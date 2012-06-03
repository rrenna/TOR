//
//  SGCharacterViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-17.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGCharacterViewController.h"
#import "SGAppDelegate.h"

@implementation SGCharacterViewController

#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGCharacter"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGCharacterViewController"];
    if(self)
    {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    raceLabel.text = [[_entity valueForKey:@"race"] valueForKey:@"Name"];
    typeLabel.text = [_entity valueForKey:@"type"];
    personalityLabel.text = [_entity valueForKey:@"personality"];
    romanceLabel.text = [_entity valueForKey:@"romanceable"];
    likesLabel.text = [_entity valueForKey:@"likes"];
    dislikesLabel.text = [_entity valueForKey:@"dislikes"];
    
    NSString* description = [_entity valueForKey:@"Description"];
    DescriptionLabel.text = (description) ? description : @"No information is known about this character at this time.";
    
    int heightSaved = 0;
    
    int savedLikesSpace = resizeLabelToTopAlignmentReturningHeightReduced(likesLabel);
    int savedDislikeSpace = resizeLabelToTopAlignmentReturningHeightReduced(dislikesLabel);
    
    moveViewForSavedSpace(dislikesLabel, savedLikesSpace);
    moveViewForSavedSpace(dislikeSectionLabel, savedLikesSpace);
    moveViewForSavedSpace(tableView, savedLikesSpace + savedDislikeSpace);
    moveViewForSavedSpace(DescriptionLabel, savedLikesSpace + savedDislikeSpace);
    
    //Remove planet table if no location assigned
    if(![_entity valueForKey:@"location"])
    {
        heightSaved += tableView.frame.size.height;
        tableView.hidden = YES;
        
        moveViewForSavedSpace(DescriptionLabel,heightSaved);
    }
    
    heightSaved += resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel); 
    resizeContentSizeForSavedSpace(scrollView, heightSaved);
}
#pragma mark - UITableView Delegate & Datasource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id entity = [_entity valueForKey:@"location"];
    SGEntityViewController* entityViewController = [[[SGAppDelegate viewerRegisteredForEntityNamed:@"SGPlanet"] alloc] initWithEntity:entity];
            
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
    id entity = [_entity valueForKey:@"location"];

    CGRect cellRect = CGRectMake(0, 0, 320, CELL_HEIGHT);
    NSString* planetPreviewFilename = [entity valueForKey:@"PreviewBackgroundFilename"];
    UIImage* backgroundImage = [UIImage imageNamed:planetPreviewFilename];

    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    cell.textLabel.shadowOffset = CGSizeMake(0,1);
    cell.textLabel.shadowColor = [UIColor darkGrayColor];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.text = [entity valueForKey:@"Name"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:cellRect] autorelease];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.backgroundColor = [UIColor blackColor];
    
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.alpha = 0.8;
    cell.backgroundView = backgroundImageView;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    return [self dividerForTitle:@"Planet" withIconKey:@"Planets"];
}
@end
