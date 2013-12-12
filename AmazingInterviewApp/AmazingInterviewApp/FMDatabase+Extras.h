//
//  FMDatabase+Extras.h
//  Owe
//
//  Created by Patrick Farrell on 19/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "FMDatabase.h"

@interface FMDatabase (Extras)

+ (FMDatabase *) openDb:(NSString *)dbPath;

@end
