//
//  FriendsPlIstLoader.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PListLoader.h"
#import "User.h"

@interface FriendsPlistLoader : PListLoader

// **** Methods **** //

-(NSArray *) pendingFriendsList;

@end
