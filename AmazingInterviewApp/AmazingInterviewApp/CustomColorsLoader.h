//
//  CustomColorsLoader.h
//  Owe
//
//  Created by Patrick Farrell on 30/11/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Additions.h"

@interface CustomColorsLoader : NSObject

@property (nonatomic, retain) NSDictionary * colorsDictionary;


//@property
//
//NSDictionary * gradesDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"definition" ofType:@"plist"]];


+ (id)sharedInstance;

- (UIColor *) customColorWithName:(NSString *) customColorName withAlpha:(float) alphaVal;

@end
