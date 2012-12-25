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
#import "TPSSDataSource.h"
#import "TPSSProfileDetailViewController.h"
@interface TPSSHomeViewController () {
  UIImage* fbProfileImage;
  NSString* fbUserName;
  NSString* fbUserId;
}
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePic;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) IBOutlet UILabel *weatherText;
@property (strong, nonatomic) IBOutlet UILabel *weatherTemp;
@property (strong, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (strong, nonatomic) IBOutlet UIButton *profileDetailButton;

@end

@implementation TPSSHomeViewController
- (IBAction)profileDetailButtonClicked:(id)sender {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSProfileDetailViewController *profileDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"profileDetailView"];
  [profileDetailViewController setUserId:[TPSSDataSource sharedDataSource].userId];
  [self.navigationController pushViewController:profileDetailViewController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}
- (void)addProfile :(NSString*)userId {
  NSDictionary* profile = [[TPSSDataSource sharedDataSource] profileWithID:userId];
  NSLog(@"%@",profile);
  
  if ( ! [profile count] ) {
    
    [TPSSDataSource createProfileWith:userId] ;
  }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ( FBSession.activeSession.isOpen) {
    }
    
    NSDictionary* weather = [[TPSSDataSource sharedDataSource] currentWeather];
    [self showWeatherWithWeatherDict:weather];
    NSLog(@"%@",weather);
}

- (void) showWeatherWithWeatherDict:(NSDictionary*)weather {
    
    NSURL *url = [NSURL URLWithString:weather[TPSSDataSourceDictKeyWeatherImage][TPSSDataSourceDictKeyWeatherImageUrl]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    [self.weatherIcon setImage:[UIImage imageWithData:imageData]];
    self.weatherText.text = weather[TPSSDataSourceDictKeyWeatherCondition][TPSSDataSourceDictKeyWeatherConditionText];
    self.weatherTemp.text = [[NSString alloc ]initWithFormat:@"%@℃", weather[TPSSDataSourceDictKeyWeatherCondition][TPSSDataSourceDictKeyWeatherConditionTemp] ];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
               [TPSSDataSource sharedDataSource].userId = user.id;
                 NSString *urlString = [NSString
                                        stringWithFormat:
                                        @"http://graph.facebook.com/%@/picture?type=square",user.id];
               [self addProfile:user.id];
                 NSURL *url = [NSURL URLWithString:urlString];
               self.userLocationLabel.text =  user.location[@"name"];
                 NSData *imageData = [NSData dataWithContentsOfURL:url];
                 [self.userProfilePic setImage:[UIImage imageWithData:imageData]];
                 
             }
         }];
    }
}

@end
