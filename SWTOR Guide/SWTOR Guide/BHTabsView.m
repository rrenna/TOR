#import "BHTabsView.h"
#import "BHTabStyle.h"

@implementation BHTabsView

@synthesize tabViews;
@synthesize style;
@synthesize delegate;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.tabViews = [NSMutableArray array];
        self.style = [BHTabStyle defaultStyle];
    }
    return self;
}
-(void)addTabNamed:(NSString*)name selected:(BOOL)selected
{
    BHTabView* tabView = [[BHTabView alloc] initWithFrame:CGRectMake(0, 0, 100, self.frame.size.height) title:name];
    tabView.selected = selected;
    
    tabView.delegate = self;
    [tabViews addObject:tabView];
    [self addSubview:tabView];
    
    if(!selected)
    {
        [self sendSubviewToBack:tabView];
    }
    
    [tabView release];
}
-(void)addTabView:(BHTabView*)tabView
{
    tabView.delegate = self;
    [tabViews addObject:tabView];
    [self addSubview:tabView];
}
- (void)layoutSubviews 
{
  NSUInteger N = [self.tabViews count];
  
  CGFloat W = self.frame.size.width / N;
  NSUInteger overlap = W * self.style.overlapAsPercentageOfTabWidth;
  W = (self.frame.size.width + overlap * (N-1)) / N;
  
  NSUInteger tabIndex = 0;
  
  for (UIView *tabView in self.tabViews) {
    CGRect tabFrame = CGRectMake(tabIndex * W,
                                 self.style.tabsViewHeight - self.style.tabHeight - self.style.tabBarHeight,
                                 W, self.style.tabHeight);
    
    if (tabIndex > 0)
      tabFrame.origin.x -= tabIndex * overlap;
    
    tabView.frame = tabFrame;
    
    tabIndex++;
  }
}

- (void)dealloc {
  self.tabViews = nil;
  self.style = nil;

  [super dealloc];
}
#pragma mark - BHTTabView delegate method
- (void)didTapTabView:(BHTabView *)tabView
{
    for(BHTabView* tab in self.tabViews)
    {
        tab.selected = NO;
    }
    
    [self bringSubviewToFront:tabView];
    tabView.selected = YES;
    
    if(delegate)
    {
        [delegate didTapTabNamed:tabView.titleLabel.text];
    }

}
@end
