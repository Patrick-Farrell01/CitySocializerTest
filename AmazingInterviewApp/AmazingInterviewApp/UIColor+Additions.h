//
//  UIColor+Additions.h
//  Owe
//
//  Created by Patrick Farrell on 26/10/2013.
//  Copyright (c) 2013 PatrickFarrellApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor*) colorFromHexString:(NSString*)hexString alpha:(float) alpha;
+ (UIColor*) colorFromHex:(uint)hex;

@end
