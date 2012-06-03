//
//  SGFlashpointViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-07.
//  Copyright 2011 None. All rights reserved.
//

#import "SGFlashpointViewController.h"
#import "SGAppDelegate.h"

@implementation SGFlashpointViewController

#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGFlashpoint"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGFlashpointViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    allegianceLabel.text = [_entity valueForKey:@"Allegiance"];
    gameLevelLabel.text = [_entity valueForKey:@"GameLevel"];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    scrollView.contentSize = CGSizeMake(320,DescriptionLabel.frame.size.height + 100);
    
    int size = resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    resizeContentSizeForSavedSpace(scrollView,size);
}
@end
