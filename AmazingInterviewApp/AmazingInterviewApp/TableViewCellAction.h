//
//  TableViewCellAction.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 16/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellAction <NSObject>

- (void) didSelectPositive;
- (void) didSelectNegative;

@end
