//
//  SGPlanetViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import "SGEntityViewController.h"
#import "SGSkillTreeViewController.h"

@interface SGPlanetViewController : SGEntityViewController <UITableViewDataSource,UITableViewDelegate>
{
    //Content View
    IBOutlet UILabel* NameLabel;
    IBOutlet UILabel* AllegianceLabel;
    IBOutlet UILabel* StatusLabel;
    IBOutlet UILabel* RegionLabel;
    IBOutlet UILabel* TerrainLabel;
    IBOutlet UITableView* tableView;
    //Datacron View
    IBOutlet UITableView* datacronView;
}
@end
