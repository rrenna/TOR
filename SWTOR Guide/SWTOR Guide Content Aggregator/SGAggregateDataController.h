//
//  SGAggregateDataController.h
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-09-03.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGAggregateDataController : NSObject
{
    NSManagedObjectContext* moc;
    //Content Storage
    NSMutableDictionary* classes;
    NSMutableDictionary* ships;
    NSMutableDictionary* skillTrees;
    NSMutableDictionary* races;
    NSMutableDictionary* locations;
}
-(IBAction)aggregate:(id)sender;
@end
