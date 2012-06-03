//
//  SGNavigationBar.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-26.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGNavigationBar.h"

@implementation SGNavigationBar

-(void) drawRect:(CGRect)rect 
{
    UIImage *image = [UIImage imageNamed: @"header"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
