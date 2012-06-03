//
//  SGWarzoneViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-08.
//  Copyright 2011 None. All rights reserved.
//

#import "SGEntityViewController.h"

@interface SGWarzoneViewController : SGEntityViewController <UITableViewDelegate,UITableViewDataSource>
{
    //Content View
    IBOutlet UILabel* TerrainLabel;
    IBOutlet UILabel* AllegianceLabel;
}
@end
