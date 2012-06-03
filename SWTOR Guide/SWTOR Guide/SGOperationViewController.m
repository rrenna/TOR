//
//  SGFlashpointViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-07.
//  Copyright 2011 None. All rights reserved.
//

#import "SGOperationViewController.h"
#import "SGAppDelegate.h"

@implementation SGOperationViewController

#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGOperation"];
}
#pragma mark - Class methods
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGOperationViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    scrollView.contentSize = CGSizeMake(320,DescriptionLabel.frame.size.height + 30);
    
    int size = resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    resizeContentSizeForSavedSpace(scrollView,size);
}
@end
