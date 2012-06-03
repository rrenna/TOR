#import <UIKit/UIKit.h>
#import "BHTabView.h"

@class BHTabStyle;

@protocol BHTabsViewDelegate <NSObject>
- (void)didTapTabNamed:(NSString *)tabName;
@end

@interface BHTabsView : UIView <BHTabViewDelegate>
{
  NSMutableArray* tabViews;
  BHTabStyle* style;
}

@property (nonatomic, retain) NSMutableArray* tabViews;
@property (nonatomic, retain) BHTabStyle* style;
@property (nonatomic, assign) id <BHTabsViewDelegate> delegate;

-(void)addTabNamed:(NSString*)name selected:(BOOL)selected;
-(void)addTabView:(BHTabView*)tabView;

@end
