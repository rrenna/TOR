//
//  SGDatacronViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 12-01-11.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "SGDatacronViewController.h"

@implementation SGDatacronViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGDatacron"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGDatacronViewController"];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    typeLabel.text = [NSString stringWithFormat:@"%@ %@",[_entity valueForKey:@"Colour"],[_entity valueForKey:@"Type"]];
    statBoostLabel.text = [_entity valueForKey:@"modifier"];
    codexLabel.text = [_entity valueForKey:@"unlocks"];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    latLabel.text = [_entity valueForKey:@"lat"];
    longLabel.text = [_entity valueForKey:@"lon"];
    allegianceLabel.text = [_entity valueForKey:@"Allegiance"];
    
    [scrollView addSubview:contentView];
    scrollView.contentSize = CGSizeMake(320,contentView.frame.size.height);
    
    int size = resizeLabelToTopAlignmentReturningHeightReduced(DescriptionLabel);
    resizeContentSizeForSavedSpace(scrollView,size);
}
@end
