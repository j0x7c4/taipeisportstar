//
//  TPSSStadiumDetailInJoinViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInJoinViewController.h"
#import "TPSSProfileDetailViewController.h"
static NSString *CellIdentifier = @"Cell";
@interface TPSSStadiumDetailInJoinViewController () {
  NSArray * events;
  NSString* selectedEventId;
}
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIImageView *stadiumImage;
@property (strong, nonatomic) IBOutlet UITableView *tableViewSportList;
@end

@implementation TPSSStadiumDetailInJoinViewController

- (IBAction)joinButtonClicked:(id)sender {
  [[FBRequest requestWithGraphPath:[[NSString alloc ]initWithFormat:@"%@/attending",selectedEventId ] parameters:nil HTTPMethod:@"POST"] startWithCompletionHandler:^(FBRequestConnection *connection,
                                                                                                                                                                      NSDictionary<FBGraphObject> *obj,
                                                                                                                                                                      NSError *error) {
    if (!error) {
      NSLog(@"event id: %@",obj);
      [[[UIAlertView alloc] initWithTitle:@"加入活動"
                                  message:@"加入成功"
                                 delegate: self
                        cancelButtonTitle:@"知道了"
                        otherButtonTitles:nil] show];
    }
    else {
      NSLog(@"%@",error);
      [[[UIAlertView alloc] initWithTitle:@"加入活動"
                                  message:@"加入失敗,可能你已經加入該活動了"
                                 delegate: self
                        cancelButtonTitle:@"知道了"
                        otherButtonTitles:nil] show];
    }
  }];

}
- (IBAction)ownerButtonClicked:(UIButton*)sender {
  NSString* owner_id = events[sender.tag][TPSSDataSourceDictKeyEventOwnerID];
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSProfileDetailViewController *profileDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"profileDetailView"];
  [profileDetailViewController setUserId:owner_id];
  [self.navigationController pushViewController:profileDetailViewController animated:YES];
}

- (IBAction)joinButtonClicked2:(UIButton*)sender {
  selectedEventId = events[sender.tag][TPSSDataSourceDictKeyEventID];
NSString* message = [[NSString alloc]initWithFormat:@"是否確定加入%@?",events[sender.tag][TPSSDataSourceDictKeyEventSport] ];
[[[UIAlertView alloc] initWithTitle:@"加入活動"
                            message:message
                           delegate: self
                  cancelButtonTitle:@"取消"
                  otherButtonTitles:@"確定",nil] show];
}
- (void)setSelectedEventId:(NSString*)eventId {
  selectedEventId = eventId;
}
- (void) setWithStadiumDictionary:(NSDictionary *)stadiumDict {
  stadium = stadiumDict;
  NSMutableArray* eventsBuffer = [[NSMutableArray alloc]init];
  for (int i = 0 ; i<[stadium[@"event"] count] ; i++ ) {
    NSDictionary *event;
    NSString* eventId = stadium[@"event"][i][@"event_id"];
    NSLog(@"%@",eventId);
    event = [[NSDictionary alloc]initWithObjectsAndKeys:eventId,TPSSDataSourceDictKeyEventID,
             stadium[@"event"][i][@"event_sport"][TPSSDataSourceDictKeySportName],TPSSDataSourceDictKeyEventSport,
             stadium[@"event"][i][TPSSDataSourceDictKeyEventOwnerID],TPSSDataSourceDictKeyEventOwnerID,
             nil];
    [eventsBuffer addObject:event];
  }
  events = [[NSArray alloc]initWithArray:eventsBuffer];
  eventsBuffer = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  if ( selectedEventId ) {
    UIButton* joinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 200;
    joinButton.frame = CGRectMake(160-buttonWidth/2, 0, buttonWidth, buttonHeight);
    [joinButton setTitle:@"加入活動" forState:UIControlStateNormal];
    [joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView addSubview:joinButton];
    
    UIButton* profileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    profileButton.frame = CGRectMake(160-buttonWidth/2, buttonHeight+10, buttonWidth, buttonHeight);
    [profileButton setTitle:@"創建者" forState:UIControlStateNormal];
    
    [profileButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView addSubview:profileButton];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = (UITableViewCell*)[tableView
                                             dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:CellIdentifier];
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    cell.textLabel.clipsToBounds = YES;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.4
                                                     green:0.6
                                                      blue:0.8
                                                     alpha:1];
    cell.detailTextLabel.clipsToBounds = YES;
  }
  NSUInteger row = indexPath.row;
  cell.textLabel.text = events[row][TPSSDataSourceDictKeyEventSport];
  NSString * ownerId = events[row][TPSSDataSourceDictKeyEventOwnerID];
  NSString *urlString = [NSString
                         stringWithFormat:
                         @"http://graph.facebook.com/%@/picture?type=square",ownerId];
  NSURL *url = [NSURL URLWithString:urlString];
  NSData *imageData = [NSData dataWithContentsOfURL:url];
  cell.imageView.image = [UIImage imageWithData:imageData];
  UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
  joinButton.tag = row;
  [joinButton addTarget:self action:@selector(joinButtonClicked2:) forControlEvents:UIControlEventTouchUpInside];
  joinButton.frame = CGRectMake(cell.frame.size.width-joinButton.frame.size.width-20, cell.frame.size.height/2-joinButton.frame.size.height/2, joinButton.frame.size.width,joinButton.frame.size.height);
  [cell addSubview:joinButton];
  UIButton *ownerButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
  ownerButton.tag = row;
  ownerButton.frame = CGRectMake(cell.frame.size.width-ownerButton.frame.size.width-50-joinButton.frame.size.width, cell.frame.size.height/2-ownerButton.frame.size.height/2, ownerButton.frame.size.width,ownerButton.frame.size.height);
  [ownerButton addTarget:self action:@selector(ownerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
  [cell addSubview:ownerButton];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [events count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    [[FBRequest requestWithGraphPath:[[NSString alloc ]initWithFormat:@"%@/attending",selectedEventId ] parameters:nil HTTPMethod:@"POST"] startWithCompletionHandler:^(FBRequestConnection *connection,
                                                                             NSDictionary<FBGraphObject> *obj,
                                                                             NSError *error) {
      if (!error) {
        NSLog(@"event id: %@",obj);
          [[[UIAlertView alloc] initWithTitle:@"加入活動"
                                      message:@"加入成功"
                                      delegate: self
                            cancelButtonTitle:@"知道了"
                            otherButtonTitles:nil] show];
      }
      else {
        NSLog(@"%@",error);
        [[[UIAlertView alloc] initWithTitle:@"加入活動"
                                    message:@"加入失敗,可能你已經加入該活動了"
                                   delegate: self
                          cancelButtonTitle:@"知道了"
                          otherButtonTitles:nil] show];
      }
    }];
  }
}
@end
