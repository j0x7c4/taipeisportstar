//
//  TPSSStadiumDetailInJoinViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInJoinViewController.h"

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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
  cell.detailTextLabel.text = @"創建者 參加人數";
  
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
  selectedEventId = events[indexPath.row][TPSSDataSourceDictKeyEventID];
  NSString* message = [[NSString alloc]initWithFormat:@"是否確定加入%@?",events[indexPath.row][TPSSDataSourceDictKeyEventSport] ];
  [[[UIAlertView alloc] initWithTitle:@"加入活動"
                              message:message
                             delegate: self
                    cancelButtonTitle:@"取消"
                    otherButtonTitles:@"確定",nil] show];
  
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
