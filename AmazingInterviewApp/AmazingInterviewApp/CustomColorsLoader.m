//
//  CustomColorsLoader.m
//  Owe
//
//  Created by Patrick Farrell on 30/11/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "CustomColorsLoader.h"

@implementation CustomColorsLoader
@synthesize colorsDictionary;

+ (CustomColorsLoader *) sharedInstance
{
    static dispatch_once_t pred;
    static CustomColorsLoader * shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[CustomColorsLoader alloc] init];
    });
    

    return shared;
}

//Overide the init method
- (id)init
{
    self = [super init];
    if (self)
    {
        //load and assign the colors dictionary
        [self setColorsDictionary:[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CustomColors" ofType:@"plist"]]];
    }
    
    return self;
}

// Return a UIColor pointer using the name from the Color in the CustomColors Plist
- (UIColor *) customColorWithName:(NSString *) customColorName withAlpha:(float) alphaVal
{
    //use the name of the color in param to get the hex value associated in the plist
    NSString * hexValue = [[self colorsDictionary] objectForKey:customColorName];
    
    //use the UIColors category method to construct a UIColor from hex value
    UIColor * customColor = [UIColor colorFromHexString:hexValue alpha:alphaVal];
    
    return customColor;
}


@end
