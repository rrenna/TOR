//
//  SGPlanetViewController.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SGAppDelegate.h"
#import "SGPlanetViewController.h"
#import "SGEntityViewController.h"

@interface SGSkillTreeViewController()
-(UIView*)generateSkillIconForSkill:(id)skill withTag:(int)tag;
-(void)displaySkillTreeDescription;
-(void)displaySkillDescriptionWithSender:(id)sender;
@end

@implementation SGSkillTreeViewController
#pragma mark - Class methods
+(void)load
{
    [super load];
    [SGAppDelegate registerSelf:self asViewerForEntityNamed:@"SGSkillTree"];
}
#pragma mark - View lifecycle
-(id)initWithEntity:(id)entity
{
    self = [super initWithEntity:entity andXibName:@"SGSkillTreeViewController"];
    skills = [[[_entity valueForKey:@"skills"] allObjects] retain];
    return self;
}
-(void)dealloc
{
    [skills release];
    [super dealloc];
}
#define NUMBER_OF_TIERS 7
#define HEIGHT_OF_TIER 86
#define WIDTH_OF_TIER 70
- (void)viewDidLoad
{
    [super viewDidLoad];
    DescriptionLabel.text = [_entity valueForKey:@"Description"];
    
    [scrollView performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:1.0];
    
    for(int tier = 1; tier <= NUMBER_OF_TIERS; tier++)
    {
        int x = 15;
        int y = (tier * HEIGHT_OF_TIER) - 47;
        UIImage* highlightTexture = [UIImage imageNamed:@"smallHighlightTexture"];
        UIImageView* tierIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        tierIcon.image = highlightTexture;
        tierIcon.alpha = 1.0;
        tierIcon.opaque = YES;
        
        UILabel* tierLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 30, 35)];
        tierLabel.text = [NSString stringWithFormat:@"Tier %d",tier];
        tierLabel.numberOfLines = 2;
        tierLabel.backgroundColor = [UIColor clearColor];
        tierLabel.textColor = [UIColor darkGrayColor];
        //tierLabel.shadowColor = [UIColor lightGrayColor];
        //tierLabel.shadowOffset = CGSizeMake(1.0, 1.0);
        tierLabel.font = [UIFont fontWithName:@"Helvetica" size:9];
        
        //UIView* tierBackground = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,35)];
        //tierBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        //tierBackground.center = CGPointMake(160,y + 45);
        tierIcon.center = CGPointMake(x,y);
        tierLabel.center = CGPointMake(x + 4,y);
        
        //[scrollView addSubview:tierBackground];
        [scrollView addSubview: tierIcon];
        [scrollView addSubview:tierLabel];
        //[tierBackground release];
        [tierIcon release];
        [tierLabel release];
    }
    
    int height = 0;
    int counters[NUMBER_OF_TIERS] = {0,0,0,0,0,0,0}; 
    for(id skill in skills)
    {
        int tier = [[skill valueForKey:@"tier"] intValue];
        int index = [skills indexOfObject:skill];
        UIView* skillIcon = [self generateSkillIconForSkill:skill withTag:index];
        
        int x = counters[tier] * WIDTH_OF_TIER + 65;
        int y = (tier * HEIGHT_OF_TIER) - 35;
        
        skillIcon.center = CGPointMake(x,y);
        [scrollView addSubview: skillIcon];
        counters[tier] ++;
        if(y > height) height = y + skillIcon.frame.size.height;
    }
    
    scrollView.contentSize = CGSizeMake(320, 6 * HEIGHT_OF_TIER);
}
#pragma mark - Private methods
-(UIView*)generateSkillIconForSkill:(id)skill withTag:(int)tag
{
    CGRect frame = CGRectMake(0, 0, 70, 95);
    //CGRect contentFrame = CGRectMake(0, 0, 75, 75);
    CGRect contentInnerFrame = CGRectMake(20, 18, 35, 35);
    CGRect labelFrame = CGRectMake(5, 63, 65, 32);
    
    UIView* skillIcon = [[UIView alloc] initWithFrame:frame];
    
    //Icon
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:contentInnerFrame];
    NSString*  iconFileName = [[skill valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    UIImage* iconImage = [UIImage imageNamed:iconFileName];
    if(!iconImage) iconImage = [UIImage imageNamed:@"Unknown"];
    
    //iconView.layer.borderWidth = 2.0;
    iconView.layer.cornerRadius = 5.0;
    iconView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    iconView.layer.masksToBounds = YES;
    iconView.image = iconImage;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    [skillIcon addSubview:iconView];
    
    //Label
    UILabel* iconLabel = [[UILabel alloc] initWithFrame:labelFrame];
    //iconLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    //iconLabel.layer.cornerRadius = 5.0;
    
    iconLabel.backgroundColor = [UIColor clearColor];
    iconLabel.numberOfLines = 2;
    iconLabel.textAlignment = UITextAlignmentCenter;
    iconLabel.textColor = [UIColor whiteColor];
    iconLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
    iconLabel.adjustsFontSizeToFitWidth = YES;
    iconLabel.minimumFontSize = 5;
    iconLabel.text = [skill valueForKey:@"Name"];
    [skillIcon addSubview:iconLabel];
    
    //Icon Button
    UIButton* iconButton = [[UIButton alloc] initWithFrame:frame];
    [iconButton addTarget:self action:@selector(displaySkillDescriptionWithSender:) forControlEvents:UIControlEventTouchDown];
    iconButton.tag = tag;
    
    [skillIcon addSubview:iconButton];
    
    return [skillIcon autorelease];
}
-(void)displaySkillDescriptionWithSender:(id)sender
{
    int index = [sender tag];
    id skill = [skills objectAtIndex:index];
    skillHeadlineLabel.text = [skill valueForKey:@"Type"];
    
    if([skillHeadlineLabel.text isEqualToString:@"Instant"])
    {
        skillHeadlineLabel.textColor = [UIColor orangeColor];
    }
    else if([skillHeadlineLabel.text isEqualToString:@"Passive"])
    {
        skillHeadlineLabel.textColor = [UIColor purpleColor];
    }
    else
    {
        skillHeadlineLabel.textColor = [UIColor whiteColor];
    }
    
    skillDescriptionLabel.text = [skill valueForKey:@"Description"]; 
}
-(void)resetSkillDescriptionWithSender:(id)sender
{
    skillHeadlineLabel.text = @"Please select a skill";
    skillDescriptionLabel.text = @"";
}
@end
