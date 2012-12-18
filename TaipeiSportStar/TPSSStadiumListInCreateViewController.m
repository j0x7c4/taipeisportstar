//
//  TPSSStadiumListInCreateViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumListInCreateViewController.h"
#import "TPSSDataSource.h"
#import "TPSSStadiumDetailInCreateViewController.h"
static NSString *CellIdentifier = @"Cell";
@interface TPSSStadiumListInCreateViewController () {
  NSString* sport;
}

@end

@implementation TPSSStadiumListInCreateViewController

- (id) initWithSportName:(NSString *)sportName {
  if ( self = [super init] ) {
    sport = sportName;
  }
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
  return [[[TPSSDataSource sharedDataSource] arrayWithStadiumsBySport:sport] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
  NSUInteger row = indexPath.row;
  NSDictionary *stadium = [[TPSSDataSource sharedDataSource] arrayWithStadiumsBySport:sport][row];
  cell.textLabel.text = stadium[TPSSDataSourceDictKeyStadiumName];
  cell.textLabel.adjustsFontSizeToFitWidth = YES;
  cell.textLabel.minimumScaleFactor = .75f;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Fetch data by index path from data source
  NSUInteger row = indexPath.row;
  
  NSDictionary *stadium = [[TPSSDataSource sharedDataSource] arrayWithStadiumsBySport:sport][row];
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSStadiumDetailInCreateViewController *stadiumDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"stadiumDetailInCreate"];
  
  NSArray * sports = [stadium[TPSSDataSourceDictKeyStadiumSports] allValues];
  
  NSPredicate *predicter = [NSPredicate predicateWithFormat:@"name = %@",self.title];
  NSArray* results = [sports filteredArrayUsingPredicate:predicter];
  if ( [results count] > 0 ) {
    [stadiumDetailViewController setWithStadiumDictionary:stadium];
    [stadiumDetailViewController setSelectedSport:results[0]];
    [self.navigationController pushViewController:stadiumDetailViewController animated:YES];
  }
  
}

@end
