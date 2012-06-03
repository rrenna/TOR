//
//  LoginViewController.h
//  EPiC2
//
//  Created by Alan Zeino on 3/02/11.
//  Copyright 2011 Alan Zeino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstapaperKit.h"

@interface AZLoginViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,IKEngineDelegate>
{
	IBOutlet UITableView *loginTableView;
@private
    UITextField* loginField;
    UITextField* passwordField;
}

@end
