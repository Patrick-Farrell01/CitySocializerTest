//
//  MyFriendsViewController.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FriendsViewController.h"
#import "DatabaseDAO.h"
#import "UserAccountManager.h"
#import "FriendRequestTableViewCell.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController
@synthesize friends;

#pragma LifeCycle Methods

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        [self setTitle:@"Friends"];
        [self setPendingFriendsLoader:[[FriendsPlistLoader alloc] initWithPlist:@"FriendRequestList"]];
        [[self pendingFriendsLoader] loadPListDictionary];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableViewFriends] setDelegate:self];
    [[self tableViewFriends] setDataSource:self];
    
    [self customiseUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    // populate the data of IOwes
    [self populateViewControllerData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TABLE View Delegate Methods

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self friends] count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    //if it is not a friends list (it is a friend request list)
    if ([self isFriendsList] == NO)
    {
        cell = [self cellForFriendRequestList:tableView atIndex:indexPath];
    }
    else
    {
        cell = [self cellForFriendList:tableView atIndex:indexPath];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma Instance Methods

// Cutomise UI Elements
- (void) customiseUI
{
    //cutomise the content inset of the tableview
    [[self tableViewFriends] setContentInset:UIEdgeInsetsMake(-50, 0, 0, 0)];
    
//    //get the count of the friends list
//    int count = [[self pendingFriendsLoader] getPendingFriendCount];
//    NSString * countString = [NSString stringWithFormat:@"%d", count];
//
//    //set the title of the pending friends title indicating the count of friend requests
//    NSString * buttonTitle = [NSString stringWithFormat:@"Friend Requests(%@)", countString];
//    [[self btnFriendRequests] setTitle:buttonTitle forState:UIControlStateNormal];
    
    
    //customise the UI of the 'friends' and 'friend requests' buttons
    [[[self btnFriendRequests] layer] setMasksToBounds:YES];
    [[[self btnFriendRequests] layer] setCornerRadius:7.0f];
    [[[self btnFriendRequests] layer] setBorderWidth:1.0f];
    [[[self btnFriendRequests] layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [[[self btnFriends] layer] setMasksToBounds:YES];
    [[[self btnFriends] layer] setCornerRadius:7.0f];
    [[[self btnFriends] layer] setBorderWidth:1.0f];
    [[[self btnFriends] layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
}

// Set the count display of the button
- (void) setCountOfFriendRequestButton:(int) count
{
    NSString * countString = [NSString stringWithFormat:@"%d", count];
    
    //set the title of the pending friends title indicating the count of friend requests
    NSString * buttonTitle = [NSString stringWithFormat:@"Friend Requests(%@)", countString];
    [[self btnFriendRequests] setTitle:buttonTitle forState:UIControlStateNormal];
}

// Populate all the data that the ViewController uses/displays
- (void) populateViewControllerData
{
    //load the friend requests when view controller loads
    [self loadFriendRequestData];

}

// Load the current friends data from Db
- (void) loadCurrentFriends
{
    DatabaseDAO * dao = [DatabaseDAO sharedInstance];
    
    [dao openDB];
    [self setFriends:
     [dao readAllFriendsForUser:[[[UserAccountManager sharedInstance] currentUser] userID]]];
    [dao closeDB];
    
    //change the color of the buttons for UX sake
    [[self btnFriends] setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[self btnFriendRequests] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    //set flag indicating that the friends list is a current friends list and not friend requests
    [self setIsFriendsList:YES];

}

// Load the friend requests (from plist but would be from some external api)
- (void) loadFriendRequestData
{
    //load the plist with friend requests
    FriendsPlistLoader * loader = [[FriendsPlistLoader alloc] initWithPlist:@"FriendRequestList"];
    [loader loadPListDictionary];
    
    NSMutableArray * pendingFriends = [[NSMutableArray alloc] initWithArray:[loader pendingFriendsList]];
    NSMutableArray * currentFriends = [[NSMutableArray alloc] initWithArray:[self getCurrentFriendsFromDB]];
    NSMutableArray * pendingFriendsToDiscard = [[NSMutableArray alloc] init];
    
    
    //loop through two arrays and
    for (User * pendingFriend in pendingFriends)
    {
        for (User * currentFriend in currentFriends)
        {
            if([[pendingFriend userID] isEqualToString:[currentFriend userID]])
            {
                [pendingFriendsToDiscard addObject:pendingFriend];
            }
        }
    }
    
    //remove the necessary objects
    [pendingFriends removeObjectsInArray:[pendingFriendsToDiscard copy]];
    
    
    //once removed desired friends, alter the count
    [self setCountOfFriendRequestButton:[pendingFriends count]];
    
    [self setFriends:[pendingFriends copy]];
    
    //change the color of the buttons for UX sake
    [[self btnFriendRequests] setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[self btnFriends] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    //set flag indicating that the friends list is a friend request list and not current friends
    [self setIsFriendsList:NO];
}

// Gets the current friends from the database
- (NSArray *) getCurrentFriendsFromDB
{
    NSMutableArray * friends;
    
    DatabaseDAO * dao = [DatabaseDAO sharedInstance];
    
    [dao openDB];
    friends =
        [[NSMutableArray alloc] initWithArray:[dao readAllFriendsForUser:[[[UserAccountManager sharedInstance] currentUser] userID]]];
    [dao closeDB];
    
    return friends;
}

// Return a cell for the current friends table
- (UITableViewCell *) cellForFriendList:(UITableView *)tableView atIndex:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    User * friend = [[self friends] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[friend username]];
    return cell;
}

// Return a cell for the friend request table
- (UITableViewCell *) cellForFriendRequestList:(UITableView *)tableView atIndex:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"FriendRequestCell";
    
    FriendRequestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        NSArray *nibObjects = [[NSBundle mainBundle]loadNibNamed:@"FriendRequestTableViewCell" owner:nil options:nil];
        for (id currentObject in nibObjects)
        {
            if([currentObject isKindOfClass:[FriendRequestTableViewCell class]])
            {
                cell = (FriendRequestTableViewCell *) currentObject;
            }
        }
    }
    
    User * friend = [[self friends] objectAtIndex:[indexPath row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setCellUser:friend];
    [cell setCellActionDelegate:self];
    
    
    [[cell labelUsername] setText:[friend username]];
    return cell;
}

#pragma Mark Protocol Methods 

// The cell was selected with positive
- (void) didSelectPositiveWithUser:(User *) userToAccept
{
    //add the friendID to the user
    NSString * currentUserID = [[[UserAccountManager sharedInstance] currentUser] userID];
    [userToAccept setFriendID:currentUserID];
    
    //accept friend request
    DatabaseDAO * dao = [DatabaseDAO sharedInstance];
    [dao openDB];
    [dao createUserInDB:userToAccept];
    [dao closeDB];
    
    [self loadFriendRequestData];
    [[self tableViewFriends] reloadData];
}

// The cell was selected with negative
- (void) didSelectNegativeUser:(User *) userToDecline;
{
    //decline friend request with special marked friendID.
//    [userToDecline setFriendID:@"xx"];
//    
//    //accept friend request
//    DatabaseDAO * dao = [DatabaseDAO sharedInstance];
//    [dao openDB];
//    [dao createUserInDB:userToDecline];
//    [dao closeDB];
//    
//    [self loadFriendRequestData];
//    [[self tableViewFriends] reloadData];
}


// Envoked when the 'Friends' is tapped
- (IBAction)friendsButtonClicked:(id)sender
{
    [self loadCurrentFriends];
    [[self tableViewFriends] reloadData];
}

// Envoked when the 'Friends Request' is tapped
- (IBAction)friendRequestButtonClicked:(id)sender
{
    [self loadFriendRequestData];
    [[self tableViewFriends] reloadData];
}


@end


