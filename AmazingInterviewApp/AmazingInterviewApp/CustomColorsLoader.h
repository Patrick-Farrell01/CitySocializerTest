//
//  CustomColorsLoader.h
//  Owe
//
//  Created by Patrick Farrell on 30/11/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

// TODO: Refactor to only load the plist when we want

#import <Foundation/Foundation.h>
#import "PListLoader.h"
#import "UIColor+Additions.h"

@interface CustomColorsLoader : PListLoader

//@property (nonatomic, retain) NSDictionary * colorsDictionary;


//@property
//
//NSDictionary * gradesDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"definition" ofType:@"plist"]];


//+ (id)sharedInstance;

- (UIColor *) customColorWithName:(NSString *) customColorName withAlpha:(float) alphaVal;

@end
