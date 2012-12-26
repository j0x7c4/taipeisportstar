//
//  TPSSFriendListViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/26/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSFriendListViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TPSSDataSource.h"
#import "TPSSMultiSelectTableViewCell.h"
@interface TPSSFriendListViewController () {
  NSString* eventId;
  NSMutableArray* friendList;
  UISearchBar* searchBar;
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end
@implementation TPSSFriendListViewController
@synthesize searchBar;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setEventId: (NSString*) eid {
  eventId = eid;
}
- (void)doneButtonClicked:(UIBarButtonItem*)sender {
  NSMutableArray *selectedFriendName = [[NSMutableArray alloc]init];
  NSMutableArray *selectedFriendID = [[NSMutableArray alloc]init];
  for ( int i=0 ; i<[friendList count]; i++ ) {
    if ( [(NSNumber *)[_selFlags objectAtIndex:i] boolValue] ) {
      [selectedFriendName addObject:friendList[i][TPSSDataSourceDictKeyFacebookName]];
      [selectedFriendID addObject:friendList[i][TPSSDataSourceDictKeyFacebookID]];
    }
  }
  if ( FBSession.activeSession.isOpen ) {
    NSString* invitList = [selectedFriendID componentsJoinedByString:@","];
    NSString *url = [[NSString alloc]initWithFormat:@"%@/invited?users=%@",eventId,invitList ];
    NSDictionary *parameter = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    FBSession.activeSession.accessToken,@"access_token",nil];
    [[FBRequest requestWithGraphPath:url
                         parameters:parameter
                         HTTPMethod:@"POST"]startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphObject> *obj,NSError *error) {
      if (!error) {
        NSString *message =[[ NSString alloc] initWithFormat:@"%@邀請成功",[selectedFriendName componentsJoinedByString:@","] ];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"邀請好友" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
      }
      else {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"邀請好友" message:@"有好友已經被邀請了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
      }
    }];

  }
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  self.title = @"邀請好友";
  self.tableView.allowsMultipleSelectionDuringEditing = YES;
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成"
                                                                style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked:)];
  self.navigationItem.rightBarButtonItem = doneButton;
  
  if ( FBSession.activeSession.isOpen ) {
    NSString* accessToken = FBSession.activeSession.accessToken;
    [[FBRequest requestWithGraphPath:[[NSString alloc]initWithFormat:@"me/friends?access_token=%@",accessToken ]
                          parameters:nil
                          HTTPMethod:@"GET"] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphObject> *obj,NSError *error) {
      if (!error) {
        friendList = [[NSMutableArray alloc]init];
        for ( NSDictionary* item in obj[@"data"] ) {
          [friendList addObject:item];
        }
        NSLog(@"%@",friendList);
        _selFlags = [[NSMutableArray alloc]initWithCapacity:[friendList count]];
        for ( int i=0 ; i<[friendList count] ; i++ ){
          [_selFlags addObject:[NSNumber numberWithBool:NO]];
        }
      [self.tableView reloadData];
      }
      else {
        NSLog(@"%@",error);
      }
    }];
  }

  NSLog(@"%@",friendList);
  //friendList = [[NSArray alloc]initWithObjects:@"Mike",@"Kiki",@"廖建科",@"符劼",@"吳承恩",@"曾毅修",@"Jane",@"Lucy", @"John", nil];
  
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [friendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  NSInteger row= indexPath.row;
  TPSSMultiSelectTableViewCell *cell = (TPSSMultiSelectTableViewCell*)[tableView
                                             dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[TPSSMultiSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundView = [[UIView alloc] init];
  }
  
  if (friendList) {
    cell.textLabel.text = friendList[indexPath.row][@"name"];
    cell.mSelected = [(NSNumber *)[_selFlags objectAtIndex:indexPath.row] boolValue];
  }
  else {
    cell.textLabel.text = @"";
    cell.mSelected = NO;
  }
  return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

*/
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  TPSSMultiSelectTableViewCell *cell = (TPSSMultiSelectTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
  [cell changeMSelectedState];
  [_selFlags replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:cell.mSelected]];
  //[self.tableView reloadData];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  [self.searchBar setShowsCancelButton:YES animated:YES];
  self.tableView.scrollEnabled = NO;
  self.tableView.allowsMultipleSelection = NO;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  self.searchBar.text = @"";
  [self.searchBar setShowsCancelButton:NO animated:YES];
  [self.searchBar resignFirstResponder];
  self.tableView.allowsMultipleSelection= YES;
  self.tableView.scrollEnabled = YES;
}
@end
