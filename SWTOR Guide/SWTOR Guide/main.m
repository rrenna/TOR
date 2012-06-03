//
//  main.m
//  SWTOR Guide
//
//  Created by Ryan Renna on 11-08-26.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "SGAppDelegate.h"

int main(int argc, char *argv[])
{
    //Register PARSE app id
    #ifdef DEBUG
    [Parse setApplicationId:@"E1Pjme4V02PSxffGOOlfokkJjpJ7Ee4vB4FApR02" 
                  clientKey:@"avuHYvSodtspQ1K66dqDI676rfxtTSFedt74Lu3v"];
    #else
    [Parse setApplicationId:@"naOVbblKsojmKe8wVamZORteqfITif9C662SC2Uk" 
                  clientKey:@"4q8WdozfrWM3KhcVrPCjfmoSOhGWqurH4EVIQNz9"];
    #endif
    //Register for Parse-Facebook hook
    [Parse setFacebookApplicationId:@"280453928664044"];
    
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
