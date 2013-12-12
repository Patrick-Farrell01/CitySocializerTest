//
//  FMDatabaseManager.m
//  Owe
//
//  Created by Patrick Farrell on 19/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "FMDatabaseManager.h"
#import "FMDatabase.h"

@implementation FMDatabaseManager

//SYNTHESIZE_SINGLETON_FOR_CLASS(FMDatabaseManager)


+(FMDatabaseManager *) sharedInstance
{
    static dispatch_once_t pred;
    static FMDatabaseManager * shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[FMDatabaseManager alloc] init];
    });
    
    return shared;
}

- (NSString *) dbPath:(NSString *)dbName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	
	return [documentsDir stringByAppendingPathComponent:dbName];
}

- (FMDatabase *) openDb:(NSString *)dbName
{
	FMDatabase* db = [FMDatabase databaseWithPath:[self dbPath:dbName]];
	if (![db open]) {
		[NSException raise:@"DbOpenError" format:@"Could not open db."];
		[db setShouldCacheStatements:NO];
		return nil;
	}
	
	[db setBusyRetryTimeout:1000];
	[db setCrashOnErrors:YES];
	
#ifdef DEBUG
	[db setLogsErrors:YES];
	//[db setTraceExecution:YES];
	
#endif
	
	return db;
}

- (void) copyDatabaseIfNeeded:(NSString *)dbName
{
	// Using NSFileManager we can perform many file system operations
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self dbPath:dbName];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success)
	{
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if(!success)
			NSAssert1(0,@"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
	
}


@end
