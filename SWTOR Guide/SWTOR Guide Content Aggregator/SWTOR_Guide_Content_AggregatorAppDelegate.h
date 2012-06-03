//
//  SWTOR_Guide_Content_AggregatorAppDelegate.h
//  SWTOR Guide Content Aggregator
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SGAggregateDataController.h"

@interface SWTOR_Guide_Content_AggregatorAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow *window;
    NSPersistentStoreCoordinator *__persistentStoreCoordinator;
    NSManagedObjectModel *__managedObjectModel;
    NSManagedObjectContext *__managedObjectContext;
    
    IBOutlet SGAggregateDataController* aggregateDataController;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

+(SWTOR_Guide_Content_AggregatorAppDelegate*)delegate;

- (IBAction)saveAction:(id)sender;

@end
