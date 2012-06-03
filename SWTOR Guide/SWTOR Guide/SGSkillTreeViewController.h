//
//  SGPlanetViewController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import "SGEntityViewController.h"

@interface SGSkillTreeViewController : SGEntityViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView* skillView;
    IBOutlet UILabel* skillHeadlineLabel;
    IBOutlet UILabel* skillDescriptionLabel;
    //Content
    NSArray* skills;
}
@end
