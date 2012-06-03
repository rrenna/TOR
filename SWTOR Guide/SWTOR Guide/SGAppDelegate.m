//
//  SGAppDelegate.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-08-26.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "SGAppDelegate.h"
#import "iRate.h"

static NSMutableDictionary* entityTypeViewerClasses;

@implementation SGAppDelegate

@synthesize window = _window;
@synthesize navigationController,engine;

#pragma mark - Class methods
+ (void)initialize
{
    //configure iRate
    [iRate sharedInstance].appStoreID = 463743698;
    [iRate sharedInstance].applicationName = @"T.O.R. Codex";
}
+(SGAppDelegate*)delegate
{
    UIApplication* app = [UIApplication sharedApplication];
    return [app delegate];
}
+(void)registerSelf:(id)class asViewerForEntityNamed:(NSString*)entityName
{
    if(!entityTypeViewerClasses) { entityTypeViewerClasses = [NSMutableDictionary new]; }
    
    [entityTypeViewerClasses setObject:class forKey:entityName];
}
+(Class)viewerRegisteredForEntityNamed:(NSString*)entityName
{
    return [entityTypeViewerClasses objectForKey:entityName];
}
#pragma mark - Instance methods
- (void)dealloc
{
    [_window release];
    [navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    // Configure Instapaper engine
    [IKEngine setOAuthConsumerKey:@"Iemiy9RyaF3TEt1twJ56IkVtAP9IIDXe9ko393GAnmwBfjKVAZ"
                andConsumerSecret:@"CiOSdtwYboYyQZngLPJCTAhGcoDIT5QNIm1UGGGa4BgjGh9ZXB"];
    engine = [[IKEngine alloc] initWithDelegate:self];
    
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}
//Facebook Integration
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[PFUser facebook] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PFUser facebook] handleOpenURL:url]; 
}
//Push Notification
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // Tell Parse about the device token.
    [PFPush storeDeviceToken:newDeviceToken];
    // Subscribe to the global broadcast channel.
    [PFPush subscribeToChannelInBackground:@""];
}
- (void)application:(UIApplication *)application 
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if ([error code] == 3010) {
        NSLog(@"Push notifications don't work in the simulator!");
    } else {
        NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}
- (void)application:(UIApplication *)application 
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
//
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - Core data
- (NSManagedObjectContext *) managedObjectContext {
	if (managedObjectContext != nil) {
		return managedObjectContext;
	}
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator: coordinator];
	}
	return managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel {
	if (managedObjectModel != nil) {
		return managedObjectModel;
	}
	managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	return managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (persistentStoreCoordinator != nil) {
		return persistentStoreCoordinator;
	}
	NSURL *storeUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SWTORGuide" ofType:@"sqlite"]];
	
	NSError *newStoreCreationError = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
								  initWithManagedObjectModel:[self managedObjectModel]];
    
	
	if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												 configuration:nil URL:storeUrl options:nil error:&newStoreCreationError]) 
    {
        
        NSLog(@"%@",[newStoreCreationError description]);
		/*Error for store creation should be handled in here*/
	}
	//If persistent store was created successfully, delete the previous storage location
	return persistentStoreCoordinator;
}
@end
