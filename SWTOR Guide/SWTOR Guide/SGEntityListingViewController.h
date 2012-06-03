//
//  SGEntityListingViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-02.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"

@interface SGEntityListingViewController : SGViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSManagedObjectContext* moc;
    NSDictionary* entities;
    IBOutlet UIToolbar* sortToolbar;
    IBOutlet UISegmentedControl* sortSegmentedControl;
    IBOutlet UITableView* tableView;
}
@property (retain) NSString* entityPredicateString;

-(id)initWithEntityName:(NSString*)_entityName;
-(id)initWithEntityName:(NSString*)_entityName andTitle:(NSString*)title;

-(IBAction)changeSortedBy:(id)sender;

@end
