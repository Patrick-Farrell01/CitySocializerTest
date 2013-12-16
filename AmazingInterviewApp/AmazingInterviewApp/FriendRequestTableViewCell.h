//
//  FriendRequestTableViewCell.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 16/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellAction.h"
#import "User.h"

@interface FriendRequestTableViewCell : UITableViewCell

// **** Members **** //
@property (strong, nonatomic) IBOutlet UILabel *labelUsername;
@property (weak) id <TableViewCellAction> cellActionDelegate;
@property (nonatomic, strong) User * cellUser;

// **** Methods **** //
- (void) configureWithUser:(User *) user;
- (IBAction)acceptFriendClicked:(id)sender;
- (IBAction)declineFriendClicked:(id)sender;

@end
