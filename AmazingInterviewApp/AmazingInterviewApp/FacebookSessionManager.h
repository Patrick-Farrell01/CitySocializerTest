//
//  FacebookSessionManager.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 13/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookSessionManager : NSObject

+ (id) sharedInstance;

@property (strong, nonatomic) FBSession *session;

@end
