//
//  FMDatabase+Extras.m
//  Owe
//
//  Created by Patrick Farrell on 19/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "FMDatabase+Extras.h"

@implementation FMDatabase (Extras)

+ (FMDatabase *) openDb:(NSString *)dbPath
{
	FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
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

@end
