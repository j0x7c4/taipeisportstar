//
//  TPSSSportListInJoinViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/17/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSSportListInJoinViewController.h"
#import "TPSSDataSource.h"
#import "TPSSStadiumListInJoinViewController.h"

static NSString *CellIdentifier = @"Cell";
@interface TPSSSportListInJoinViewController ()

@end

@implementation TPSSSportListInJoinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
  return [[[TPSSDataSource sharedDataSource] arrayWithSportsByEvent] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  // Fetch data by index path from data source
  NSUInteger row = indexPath.row;
  NSDictionary* sport = [[TPSSDataSource sharedDataSource] arrayWithSportsByEvent][row];
  
  //set cell style and content
  cell.textLabel.text = sport[TPSSDataSourceDictKeySportName];
  cell.textLabel.adjustsFontSizeToFitWidth = YES;
  cell.textLabel.minimumScaleFactor = .75f;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Navigation logic may go here. Create and push another view controller.
  NSUInteger row = indexPath.row;
  NSDictionary *sport = [[TPSSDataSource sharedDataSource] arrayWithSportsByEvent][row];
  //Create a tableView child view
  TPSSStadiumListInJoinViewController *stadiumListViewController =[[TPSSStadiumListInJoinViewController alloc]initWithSportDict:sport];
  // Ask navigation controller to show it.
  stadiumListViewController.title = sport[TPSSDataSourceDictKeySportName];
  [self.navigationController pushViewController:stadiumListViewController animated:YES];
}


@end
