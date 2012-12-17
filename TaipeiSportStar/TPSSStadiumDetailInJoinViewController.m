//
//  TPSSStadiumDetailInJoinViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInJoinViewController.h"
#import "TPSSDataSource.h"
static NSString *CellIdentifier = @"Cell";
@interface TPSSStadiumDetailInJoinViewController () {
  NSDictionary *stadium;
}
@property (strong, nonatomic) IBOutlet UILabel *labelStadiumName;
@property (strong, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (strong, nonatomic) IBOutlet UILabel *labelSport;
@property (strong, nonatomic) IBOutlet UILabel *labelBusInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelMRTInfo;
@property (strong, nonatomic) IBOutlet UIButton *buttonJoin;
@property (strong, nonatomic) IBOutlet UITableView *tableViewSportList;

@end

@implementation TPSSStadiumDetailInJoinViewController

- (IBAction)joinButtonClicked:(id)sender {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) setWithStadiumDictionary:(NSDictionary *)stadiumDict {
  stadium = stadiumDict;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  NSLog(@"%@",stadium);
    self.title = self.labelStadiumName.text = stadium[TPSSDataSourceDictKeyStadiumName];
    self.labelBusInfo.text = stadium[TPSSDataSourceDictKeyStadiumBus];
    self.labelMRTInfo.text = stadium[TPSSDataSourceDictKeyStadiumMrt];
    self.labelOpenTime.text = stadium[TPSSDataSourceDictKeyStadiumTime];
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
    cell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
    cell.textLabel.clipsToBounds = YES;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.4
                                                     green:0.6
                                                      blue:0.8
                                                     alpha:1];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
    cell.detailTextLabel.clipsToBounds = YES;
  }
  NSUInteger row = indexPath.row;
  cell.textLabel.text = stadium[@"event"][row][@"event_sport"][TPSSDataSourceDictKeySportName];
  //cell.detailTextLabel.text = stadium[@"event"][@"event_id"];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"--------------%u",[stadium[@"event"] count]);
  return [stadium[@"event"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Do nothing for now
}
@end
