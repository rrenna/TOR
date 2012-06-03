//
//  LoginViewController.m
//  EPiC2
//
//  Created by Alan Zeino on 3/02/11.
//  Copyright 2011 Alan Zeino. All rights reserved.
//

#import "AZLoginViewController.h"

@implementation AZLoginViewController
-(id)init
{
    self = [super initWithNibName:@"AZLoginViewController" bundle:nil];
    if(self)
    {
        self.title = @"Instapaper";
    }
    return self;
}
#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	UITableViewCell *cell;
	NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AZLoginTableViewCell" 
													  owner:self 
													options:nil];
	cell = (UITableViewCell *)[nibArray objectAtIndex:0];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
	if ([indexPath row] == 0)
	{
		cell.textLabel.text = @"Username";
		loginField = (UITextField *)cell.accessoryView;
		loginField.keyboardType = UIKeyboardTypeEmailAddress;
		loginField.returnKeyType = UIReturnKeyNext;
	}
	else
	{
		cell.textLabel.text = @"Password";
		passwordField = (UITextField *)cell.accessoryView;
		passwordField.keyboardType = UIKeyboardTypeAlphabet;
		passwordField.returnKeyType = UIReturnKeyDone;
		passwordField.secureTextEntry = YES;
        passwordField.delegate = self;
        
	}
	
	return cell;
}
- (void)dealloc 
{
    [super dealloc];
}
#pragma mark - UITextField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString* loginName = loginField.text;
    NSString* passwordName = passwordField.text;
    
    IKEngine* engine = [[SGAppDelegate delegate] engine];
    engine.delegate = self;
    [engine authTokenForUsername:loginName password:passwordName userInfo:nil];
    
    [SVProgressHUD showWithStatus:@"Validating" maskType:SVProgressHUDMaskTypeClear networkIndicator:YES];
}
#pragma mark - InstapaperKit delegate methods
- (void)engine:(IKEngine *)engine connection:(IKURLConnection *)connection didReceiveAuthToken:(NSString *)token andTokenSecret:(NSString *)secret
{
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"INSTAPAPER_AUTH"];
    [[NSUserDefaults standardUserDefaults] setValue:secret forKey:@"INSTAPAPER_SECRET"];
    engine.delegate = nil;
    
    // Assign token and secret
    engine.OAuthToken  = token;
    engine.OAuthTokenSecret = secret;
    
    [SVProgressHUD dismissWithSuccess:@"Success!"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)engine:(IKEngine *)engine didFailConnection:(IKURLConnection *)connection error:(NSError *)error
{
    engine.delegate = nil;
    [SVProgressHUD dismissWithError:@"Could not validate login."];
}
@end
