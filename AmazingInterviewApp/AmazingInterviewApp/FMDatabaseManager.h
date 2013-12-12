//
//  FMDatabaseManager.h
//  Owe
//
//  Created by Patrick Farrell on 19/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
//#import "SynthesizeSingleton.h"

@interface FMDatabaseManager : NSObject

//SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(FMDatabaseManager)

+ (id)sharedInstance;

- (NSString *) dbPath:(NSString *)dbName;
- (FMDatabase *) openDb:(NSString *)dbPath;
- (void) copyDatabaseIfNeeded:(NSString *)dbName;

@end

