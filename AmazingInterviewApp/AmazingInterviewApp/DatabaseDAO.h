//
//  OweDBDAO.h
//  Owe
//
//  Created by Patrick Farrell on 08/12/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseManager.h"
#import "User.h"

@interface DatabaseDAO : NSObject

// **** Members **** //

@property (nonatomic, strong) FMDatabase * database;
@property (nonatomic, strong) NSString * databaseName;


// **** Methods **** //

+ (id) sharedInstance;

- (void) openDB;
- (void) closeDB;

- (void) createUserInDB:(User *) userToCreate;
- (NSArray *) readAllFriendsForUser:(NSString *) userID;
- (User *) readUserByUserID:(NSString *) userID;
- (void) deleteFriendWithUserID:(NSString *) userID;


@end
