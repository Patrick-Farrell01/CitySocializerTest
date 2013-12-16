//
//  FriendRequestTableViewCell.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 16/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FriendRequestTableViewCell.h"

@implementation FriendRequestTableViewCell
@synthesize cellActionDelegate, cellUser;

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

// Set the cell up with the User
- (void) configureWithUser:(User *) user
{
    [self setCellUser:user];
    [[self labelUsername] setText:[user username]];
}

// Action when accepting the Friend Request
- (IBAction)acceptFriendClicked:(id)sender
{
    //call positive on the cell protocol
    [[self cellActionDelegate] didSelectPositiveWithUser:cellUser];
}

// Action when declining the Friend Request
- (IBAction)declineFriendClicked:(id)sender
{
    //call negative on the cell protocol
    [[self cellActionDelegate] didSelectNegativeUser:cellUser];
}

@end
