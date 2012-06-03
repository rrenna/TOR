//
//  OpenSpringBoardVC.h
//  openspringboard
//
//  Created by Mobile Flow LLC on 2/21/11.
//  Copyright 2011 Mobile Flow LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"

@interface SGMenuViewController : SGViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView* menuScrollView;
    IBOutlet UIView* menuView;
    IBOutlet UIPageControl* pageControl;
}

-(IBAction)search:(id)sender;
-(IBAction)settings:(id)sender;
-(IBAction)news:(id)sender;
-(IBAction)nameGenerator:(id)sender;
-(IBAction)classes:(id)sender;
-(IBAction)crewSkills:(id)sender;
-(IBAction)starships:(id)sender;
-(IBAction)planets:(id)sender;
-(IBAction)warzones:(id)sender;
-(IBAction)operations:(id)sender;
-(IBAction)flashpoints:(id)sender;
-(IBAction)datacrons:(id)sender;
-(IBAction)serverStatus:(id)sender;
@end
