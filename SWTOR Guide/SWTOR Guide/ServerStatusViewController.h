//
//  ServerStatusViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 2012-03-06.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"

@interface ServerStatusViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    IBOutlet UIBarButtonItem* refreshButton;
    IBOutlet UITableView* tableView;
@private
    TFHpple * doc;
    BOOL displaySearchResult;
}

-(IBAction)refresh:(id)sender;
@end
