//
//  PListLoader.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "PListLoader.h"

@implementation PListLoader
@synthesize pListDictionary, fileName;

// Custom init method with a pList filename
- (id) initWithPlist:(NSString *) filename
{
    self = [super init];
    
    if(self)
    {
        [self setFileName:filename];
    }
    
    return self;
}

// Loads the File into Dictionary property
- (void) loadPListDictionary
{
    //load and assign the colors dictionary
    [self setPListDictionary:[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self fileName] ofType:@"plist"]]];
}

@end
