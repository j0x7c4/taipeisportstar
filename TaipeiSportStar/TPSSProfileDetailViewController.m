//
//  TPSSProfileDetailViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/23/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSProfileDetailViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TPSSDataSource.h"
@interface TPSSProfileDetailViewController () {
  NSString* userId;
  NSArray* events;
}
@property (strong, nonatomic) IBOutlet UILabel *numberOfEvents;
@property (strong, nonatomic) IBOutlet UIImageView *profileGenderImage;
@property (strong, nonatomic) IBOutlet UILabel *profileLocation;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@end

@implementation TPSSProfileDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserId:(NSString*)ID{
  if ( self = [super init] ) {
    userId = ID;
  }
  return self;
}
- (void)setUserId:(NSString*)ID{
  userId = ID;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  events = [[TPSSDataSource sharedDataSource]arrayWithEventsByOwnerID:userId];
  self.title = @"Profile";
  self.numberOfEvents.text = [[NSString alloc]initWithFormat:@"Has create %d events",[events count]];
  if (FBSession.activeSession.isOpen) {
    [[FBRequest requestWithGraphPath:userId
                          parameters:nil
                          HTTPMethod:@"GET"] startWithCompletionHandler:^(FBRequestConnection *connection,NSDictionary<FBGraphUser> *user,NSError *error) {
        if (!error) {
          NSString *urlString = [NSString
                                 stringWithFormat:
                                 @"http://graph.facebook.com/%@/picture?type=square",user.id];
          
          NSURL *url = [NSURL URLWithString:urlString];
          self.profileLocation.text =  user.location[@"name"];
          self.profileName.text = user.name;
          NSData *imageData = [NSData dataWithContentsOfURL:url];
          [self.profileImage setImage:[UIImage imageWithData:imageData]];
          if ([user[@"gender"] isEqualToString:@"male"]) {
            self.profileGenderImage.image = [UIImage imageNamed:@"gender_male.png"];
          }
          else {
            self.profileGenderImage.image = [UIImage imageNamed:@"gender_female.png"];
          }
        }
        else {
          NSLog(@"%@",error);
        }
      }];
  }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

@end
