//
//  SGAppDelegate.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-08-26.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "InstapaperKit.h"
#import "Parse/Parse.h"

@class SGViewController;

@interface SGAppDelegate : UIResponder <UIApplicationDelegate>
{
@private
    NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    //Instapaper engine
    IKEngine *engine;
}
+(SGAppDelegate*)delegate;


@property (retain, nonatomic) IBOutlet UIWindow *window;
@property (retain, nonatomic) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (assign) IKEngine *engine;

+(void)registerSelf:(id)class asViewerForEntityNamed:(NSString*)entityName;
+(Class)viewerRegisteredForEntityNamed:(NSString*)entityName;
@end
