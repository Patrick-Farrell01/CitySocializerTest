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
        [self setDatabaseName:@"owe.db"];
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
        NSString * sql = @"SELECT * FROM user WHERE friendID = ?";
        
        FMResultSet *results = [[self database] executeQuery:sql, [currentUser userID]];
        
        while([results next])
        {
            User * dbUser = [[User alloc] init];
            
            [dbUser setUsername:[results stringForColumn:@"username"]];
            [dbUser setUserID:[results stringForColumn:@"unique_id"]];
            
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
        NSString * sql = @"SELECT * FROM user WHERE unique_id = ?";
        FMResultSet *results = [[self database] executeQuery:sql, userID];
        
        while([results next])
        {
            [user setUsername:[results stringForColumn:@"username"]];
            [user setUserID:[results stringForColumn:@"unique_id"]];
        }
        
        [results close];
        [[self database] close];
    }
    
    return user;
}

// Read all the IOwes. An IOwe is simply an Owe where the 'from' is this users' account
- (NSArray *) readAllIOwesFromDB
{
    NSMutableArray * owes = [[NSMutableArray alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM Owe WHERE owe_from_username = ?";
        NSString * userName = [[[UserAccountManager sharedInstance] currentUser] username];
        
        FMResultSet *results = [[self database] executeQuery:sql, userName];
        
        while([results next])
        {
            Owe * dbOwe = [[Owe alloc] init];
            
            [dbOwe setOweID:[results stringForColumn:@"id"]];
            [dbOwe setOweToUsername:[results stringForColumn:@"owe_to_username"]];
            [dbOwe setOweFromUsername:[results stringForColumn:@"owe_from_username"]];
            [dbOwe setDescription:[results stringForColumn:@"description"]];
            [dbOwe setAmountRemaining:[results doubleForColumn:@"amount_remain"]];
            [dbOwe setAmountTotal:[results doubleForColumn:@"amount_total"]];
            [dbOwe setDateCreated:[AppHelperFunctions shortStyleDateFromString:[results        stringForColumn:@"dateCreated"]]];
            
            [owes addObject:dbOwe];
        }
        
    }
    
    return [owes copy];
}

// Read all the OwesMe. An OweMe is simply an Owe where the 'to' is this users' account
- (NSArray *) readAllOwesMeFromDB
{
    NSMutableArray * owes = [[NSMutableArray alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM Owe WHERE owe_to_username = ?";
        NSString * userName = [[[UserAccountManager sharedInstance] currentUser] username];
        
        FMResultSet *results = [[self database] executeQuery:sql, userName];
        
        while([results next])
        {
            Owe * dbOwe = [[Owe alloc] init];
            
            [dbOwe setOweID:[results stringForColumn:@"id"]];
            [dbOwe setOweToUsername:[results stringForColumn:@"owe_to_username"]];
            [dbOwe setOweFromUsername:[results stringForColumn:@"owe_from_username"]];
            //[dbOwe setDateCreatedFromString:[results stringForColumn:@"dateCreated"]];
            [dbOwe setDescription:[results stringForColumn:@"description"]];
            [dbOwe setAmountRemaining:[results doubleForColumn:@"amount_remain"]];
            [dbOwe setAmountTotal:[results doubleForColumn:@"amount_total"]];
            [dbOwe setDateCreated:[AppHelperFunctions shortStyleDateFromString:[results        stringForColumn:@"dateCreated"]]];
            
            [owes addObject:dbOwe];
        }
        
    }
    
    return [owes copy];
}

// Reads database table OwePayment for a payment with a specified paymentID
- (OwePayment *) readOwePaymentByPaymentID:(NSString *) paymentID
{
    OwePayment * dbOwePayment = [[OwePayment alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM OwePayments WHERE payment_id = ?";
        FMResultSet * results = [[self database] executeQuery:sql, paymentID];
        
        while([results next])
        {
            OwePayment * dbOwePayment = [[OwePayment alloc] init];
            
            [dbOwePayment setOwePaymentID:[results stringForColumn:@"payment_id"]];
            [dbOwePayment setOweID:[results stringForColumn:@"owe_id"]];
            [dbOwePayment setAmountPaid:[results doubleForColumn:@"amount_paid"]];
            [dbOwePayment setDatePaid:[AppHelperFunctions shortStyleDateFromString:[results        stringForColumn:@"date_paid"]]];
            
        }
    }
    
    return dbOwePayment;
    
}

// Reads database table OwePayment for all OwePayments with a matching oweID
- (NSArray *) readAllOwePaymentsByOweID:(NSString *) oweID
{
    NSMutableArray * owePayments = [[NSMutableArray alloc] init];
    
    if([self database] != NULL)
    {
        NSString * sql = @"SELECT * FROM OwePayments WHERE owe_id = ? ORDER BY [order_index] DESC";
        FMResultSet *results = [[self database] executeQuery:sql, oweID];
        
        while([results next])
        {
            OwePayment * dbOwePayment = [[OwePayment alloc] init];
            
            [dbOwePayment setOwePaymentID:[results stringForColumn:@"payment_id"]];
            [dbOwePayment setOweID:[results stringForColumn:@"owe_id"]];
            [dbOwePayment setAmountPaid:[results doubleForColumn:@"amount_paid"]];
            [dbOwePayment setDatePaid:[AppHelperFunctions shortStyleDateFromString:[results        stringForColumn:@"date_paid"]]];
            
            [owePayments addObject:dbOwePayment];
        }
    }
    
    return [owePayments copy];
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
