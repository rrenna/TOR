//
//  SGCraftingSkill.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-10-12.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGEntityViewController.h"

@interface SGCraftingSkillViewController : SGEntityViewController
{
    //Content View
    IBOutlet UILabel* TypeLabel;
    IBOutlet UILabel* ProducesLabel;
    //IBOutlet UILabel* DescriptionLabel;
    IBOutlet UITableView* tableView;
@private
    BOOL isCrafting;
    int numberOfSections;
    int avaliableToClassIndex;
    int relianceIndex;
    int headlineIndex;
    int descriptionIndex;
}
@end
