//
//  PListLoader.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 15/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PListLoader : NSObject

// **** Members **** //

@property (nonatomic, retain) NSDictionary * pListDictionary;
@property (nonatomic, retain) NSString * fileName;


// **** Methods **** //

- (id) initWithPlist:(NSString *) filename;
- (void) loadPListDictionary;

@end
