//
//  UIColor+Additions.m
//  Owe
//
//  Created by Patrick Farrell on 26/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Extras)

+ (UIColor*) colorFromHexString:(NSString*)hexString alpha:(float) alpha;
{
    UIColor *defaultResult = [UIColor blackColor];
    
    // Strip leading # if there is one
    if ([hexString hasPrefix:@"#"] && [hexString length] > 1)
    {
        hexString = [hexString substringFromIndex:1];
    }
    
    NSUInteger componentLength = 0;
    if ([hexString length] == 3)
        componentLength = 1;
    else if ([hexString length] == 6)
        componentLength = 2;
    else
        return defaultResult;
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    for (NSUInteger i = 0; i < 3; i++)
    {
        NSString *component = [hexString substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        
        if (componentLength == 1)
        {
            component = [component stringByAppendingString:component];
        }
        
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 256.0;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];
    
}

+ (UIColor*) colorFromHex:(uint)hex
{
    int red, green, blue, alpha;
    
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    
    
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.0f];
    
}





@end
