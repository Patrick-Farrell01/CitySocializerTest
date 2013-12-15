//
//  MyFriendsViewController.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsPlIstLoader.h"
#import "DatabaseDAO.h"
#import "UserAccountManager.h"

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self friends] count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static the reuse id of the cell.
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    User * friend = [[self friends] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[friend username]];
    
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


// Populate all the data that the ViewController uses/displays
- (void) populateViewControllerData
{
    //load the current friends
    [self loadCurrentFriends];
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

}

// Load the friend requests (from plist but would be from some external api)
- (void) loadFriendRequestData
{
    FriendsPlistLoader * loader = [[FriendsPlistLoader alloc] initWithPlist:@"FriendRequestList"];
    [loader loadPListDictionary];
    
    [self setFriends:[loader pendingFriendsList]];
    
    //change the color of the buttons for UX sake
    [[self btnFriendRequests] setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[self btnFriends] setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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


