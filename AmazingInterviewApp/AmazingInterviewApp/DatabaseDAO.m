//
//  OweDBDAO.m
//  Owe
//
//  Created by Patrick Farrell on 08/12/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "DatabaseDAO.h"
#import "UserAccountManager.h"

@implementation DatabaseDAO
@synthesize database, databaseName;


#pragma Singleton Access

// Return singleton object of the OweDAO object
+(DatabaseDAO *) sharedInstance
{
    static dispatch_once_t pred;
    static DatabaseDAO * shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DatabaseDAO alloc] init];
    });
    
    return shared;
}

#pragma Instance Methods

// Override Init for customisation
- (id)init
{
    self = [super init];
    if (self)
    {
        [self setDatabaseName:@"interview.db"];
    }
    return self;
}

// Opens the database for interaction
- (void) openDB
{
    [self setDatabase:[[FMDatabaseManager sharedInstance] openDb:[self databaseName]]];
}

// Closes the database for interaction
- (void) closeDB
{
    [[self database] close];
}


#pragma Create


- (void) createUserInDB:(User *) userToCreate;
{
    NSString * insert = @"INSERT INTO User";
    NSString * values = @"(unique_id, username, friendID) VALUES (?,?,?)";
    
    NSString * sql = [insert stringByAppendingString:values];
    
    if([self database] != NULL)
    {
        [[self database] executeUpdate:sql,
         [userToCreate userID],
         [userToCreate username],
         [userToCreate friendID]];
    }

}

#pragma Read

// Read all the friends for a particular user
- (NSArray *) readAllFriendsForUser:(NSString *) userID
{
    //get the current user
    User * currentUser = [[UserAccountManager sharedInstance] currentUser];
    
    //build array of users that have a friend ID that match the current users id
    NSMutableArray * friends = [[NSMutableArray alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM User WHERE friendID = ?";
        
        FMResultSet *results = [[self database] executeQuery:sql, [currentUser userID]];
        
        while([results next])
        {
            User * dbUser = [[User alloc] init];
            
            [dbUser setUsername:[results stringForColumn:@"username"]];
            [dbUser setUserID:[results stringForColumn:@"unique_id"]];
            [dbUser setFriendID:[results stringForColumn:@"friendID"]];
            
            [friends addObject:dbUser];
        }
        
    }
    
    return [friends copy];
}

// Read a specific User Record
- (User *) readUserByUserID:(NSString *) userID
{
     User * user = [[User alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM User WHERE unique_id = ?";
        FMResultSet *results = [[self database] executeQuery:sql, userID];
        
        while([results next])
        {
            [user setUsername:[results stringForColumn:@"username"]];
            [user setUserID:[results stringForColumn:@"unique_id"]];
            [user setFriendID:[results stringForColumn:@"friendID"]];
        }
        
        [results close];
        [[self database] close];
    }
    
    return user;
}



#pragma Update


#pragma Delete

// Delete the User by ID
- (void) deleteFriendWithUserID:(NSString *) userID
{
    if([self database] != NULL)
    {
        NSString * deleteStatementNS = @"DELETE FROM user WHERE unique_id = ?";
        [[self database] executeUpdate:deleteStatementNS,userID];
    }

}

@end
