//
//  SGTipController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-11-30.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGSubmitTipViewController.h"

@interface SGTipController : NSObject <UITableViewDelegate,UITableViewDataSource,SGSubmitTipViewDelegate>
@property (retain) NSString* parseType;
@property (retain) NSString* entityName;
@property (retain) NSArray* tips;
@property (retain) UITableView* tableView;
@property (assign) UIViewController *parentViewController;

-(void)getTips;
-(void)submit;
@end
