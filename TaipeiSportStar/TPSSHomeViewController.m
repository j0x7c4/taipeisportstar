//
//  TPSSHomeViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/6/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSHomeViewController.h"
#import "TPSSJoinSelectionMapViewController.h"
#import "TPSSCreateSelectionMapViewController.h"

@interface TPSSHomeViewController ()
@property (strong, nonatomic) IBOutlet UIButton *buttonJoin;
@property (strong, nonatomic) IBOutlet UIButton *buttonCreate;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
//@property (strong, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation TPSSHomeViewController

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
	// Do any additional setup after loading the view.
  if ( !FBSession.activeSession.isOpen) {
  }
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  if (FBSession.activeSession.isOpen) {
    [self populateUserDetails];
  }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateUserDetails
{
  if (FBSession.activeSession.isOpen) {
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphUser> *user,
       NSError *error) {
       if (!error) {
         NSLog(@"@%@,%@", user.name, user.id);
         self.userNameLabel.text = user.name;
         self.userProfileImage.profileID = user.id;
       }
     }];
  }
}
/*
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
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = @"加入活動";
      cell.detailTextLabel.text = @"加入其他人的活動。";
      //cell.imageView.image = [UIImage imageNamed:@"action-eating.png"];
      break;
      
    case 1:
      cell.textLabel.text = @"創建活動";
      cell.detailTextLabel.text = @"創建自己的活動。";
      //cell.imageView.image = [UIImage imageNamed:@"action-location.png"];
      break;
      
      
    case 2:
      cell.textLabel.text = @"說幾句吧";
      cell.detailTextLabel.text = @"發佈facebook狀態。";
      //cell.imageView.image = [UIImage imageNamed:@"action-photo.png"];
      break;
      
    default:
      break;
  }
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSJoinSelectionMapViewController *joinMapViewController = [storyboard instantiateViewControllerWithIdentifier:@"joinSelectionMapViewController"];
  
  
  switch ( indexPath.row ) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    default:
      break;
  }
}
 */
@end
