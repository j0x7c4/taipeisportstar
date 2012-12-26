//
//  TPSSStadiumListInJoinViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumListInJoinViewController.h"
#import "TPSSStadiumDetailInJoinViewController.h"
#import "TPSSDataSource.h"

static NSString *CellIdentifier = @"Cell";
@interface TPSSStadiumListInJoinViewController () {
  NSDictionary* sport;
  NSMutableArray* events;
}
@end

@implementation TPSSStadiumListInJoinViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id) initWithSportDict:(NSDictionary *)sportDict {
  if ( self=[super init] ) {
    sport = sportDict;
    events = [[NSMutableArray alloc]initWithCapacity:[sport[@"event"]count]];
    for (int i = 0 ; i<[sport[@"event"] count] ; i++ ) {
      events[i] = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",TPSSDataSourceDictKeyEventID,
                   @"",TPSSDataSourceDictKeyStadiumName,
                   @"",TPSSDataSourceDictKeyEventOwnerID,
                   @"",TPSSDataSourceDictKeyEventDetailText , nil];
      NSString* eventId = sport[@"event"][i][@"event_id"];
      [[FBRequest requestWithGraphPath:eventId
                            parameters:nil
                            HTTPMethod:@"GET"] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphObject> *obj,NSError *error) {
        if (!error) {
          NSLog(@"%@",obj[@"start_time"]);
          NSDateFormatter *dateformatterSrc = [[NSDateFormatter alloc]init];
          [dateformatterSrc setDateFormat:@"yyyy-MM-dd HH:mm:ss+0800"];
          NSString* dateStr = [[NSString alloc]initWithFormat:@"%@",obj[@"start_time"]];
          dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
          NSLog(@"date string:%@",dateStr);
          NSDate* date = [dateformatterSrc dateFromString:dateStr];
          NSLog(@"date: %@",date);
          NSDateFormatter *dateformatterDst = [[NSDateFormatter alloc]init];
          [dateformatterDst setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
          events[i][TPSSDataSourceDictKeyEventDetailText] = [dateformatterDst stringFromDate:date];
          [self.tableView reloadData];
        }
        else {
          NSLog(@"%@",error);
        }
      }];
      events[i][TPSSDataSourceDictKeyEventID] = eventId;
      events[i][TPSSDataSourceDictKeyStadiumName] = sport[@"event"][i][@"event_stadium"][TPSSDataSourceDictKeyStadiumName];
      events[i][TPSSDataSourceDictKeyEventOwnerID] = sport[@"event"][i][TPSSDataSourceDictKeyEventOwnerID];
    }
  }
  return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [sport[@"event"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Fetch data by index path from data source
  NSUInteger row = indexPath.row;
  NSDictionary* stadium = sport[@"event"][row][@"event_stadium"];
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSStadiumDetailInJoinViewController *stadiumDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"stadiumDetailInJoin"];
  [stadiumDetailViewController setWithStadiumDictionary:stadium];
  [stadiumDetailViewController setSelectedEventId:sport[@"event"][row][TPSSDataSourceDictKeyEventID]];
  [self.navigationController pushViewController:stadiumDetailViewController animated:YES];
}

@end
