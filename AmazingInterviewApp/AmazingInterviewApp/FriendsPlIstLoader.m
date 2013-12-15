//
//  FriendsPlIstLoader.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FriendsPlistLoader.h"

@implementation FriendsPlistLoader

// Return a list of friends built from plist
-(NSArray *) pendingFriendsList
{
    //array to return
    NSMutableArray * returningArray = [[NSMutableArray alloc] init];
    
    //get the array of friend requests from the plist
    NSArray * friendsDefinitions = [[self pListDictionary] objectForKey:@"FriendRequests"];
    
    //loop through the array
    for (NSDictionary *friendDict in friendsDefinitions)
    {
        User * friend = [[User alloc] init];
        [friend setUsername:[friendDict objectForKey:@"username"]];
        [friend setUserID:[friendDict objectForKey:@"userID"]];
        
        [returningArray addObject:friend];
    }
    
    return [returningArray copy];
}

@end
