//
//  SGCharacterViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-17.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGEntityViewController.h"

@interface SGCharacterViewController : SGEntityViewController
{
    //Content
    IBOutlet UILabel* raceLabel;
    IBOutlet UILabel* typeLabel;
    IBOutlet UILabel* romanceLabel;
    IBOutlet UILabel* personalityLabel;
    IBOutlet UILabel* likesLabel;
    IBOutlet UILabel* dislikeSectionLabel;
    IBOutlet UILabel* dislikesLabel;
    IBOutlet UITableView* tableView;
}

@end
