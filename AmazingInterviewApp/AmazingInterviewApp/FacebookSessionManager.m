//
//  FacebookSessionManager.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 13/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FacebookSessionManager.h"

@implementation FacebookSessionManager
@synthesize session;

+(FacebookSessionManager *) sharedInstance
{
    static dispatch_once_t pred;
    static FacebookSessionManager * shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[FacebookSessionManager alloc] init];
    });
    
    return shared;
}




@end
