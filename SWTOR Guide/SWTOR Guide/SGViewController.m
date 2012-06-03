//
//  SGViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-26.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGViewController.h"

@implementation SGViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    //Custom TitleBar
    /*
     CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.text =self.title;
    self.navigationItem.titleView = label;
     */
}

@end
