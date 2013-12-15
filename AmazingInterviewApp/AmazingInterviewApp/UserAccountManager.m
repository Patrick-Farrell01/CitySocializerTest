//
//  UserAccountManager.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "UserAccountManager.h"

@implementation UserAccountManager
@synthesize currentUser;

// Singelton access method
+(UserAccountManager *) sharedInstance
{
    static dispatch_once_t pred;
    static UserAccountManager * shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[UserAccountManager alloc] init];
    });
    
    return shared;
}

// Overiding init method
- (id)init
{
    self = [super init];
    if (self)
    {
        //set the current user details
        [self setCurrentUser:[[User alloc] init]];
        [[self currentUser] setUserID:@"12345FFFF"];
        [[self currentUser] setUsername:@"Patrick Farrell"];

    }
    
    return self;
}


@end
