//
//  FriendRequestTableViewCell.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 16/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FriendRequestTableViewCell.h"

@implementation FriendRequestTableViewCell
@synthesize cellActionDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Action when accepting the Friend Request
- (IBAction)acceptFriendClicked:(id)sender
{
    //call positive on the cell protocol
    [[self cellActionDelegate] didSelectPositive];
}

// Action when declining the Friend Request
- (IBAction)declineFriendClicked:(id)sender
{
    //call negative on the cell protocol
    [[self cellActionDelegate] didSelectNegative];
}

@end
