//
//  UserAccountManager.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserAccountManager : NSObject

+ (id) sharedInstance;

@property (nonatomic, retain) User * currentUser;

@end
