//
//  TPSSStadiumDetailBaseViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailBaseViewController.h"
#import "TPSSDataSource.h"
#import "TPSSDetailInformationViewController.h"
@interface TPSSStadiumDetailBaseViewController () {
  
}

@end

@implementation TPSSStadiumDetailBaseViewController

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
  self.stadiumImage.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.png",stadium[TPSSDataSourceDictKeyStadiumID]]];
  self.title = self.labelStadiumName.text = stadium[TPSSDataSourceDictKeyStadiumName];
    self.labelOpenTime.text = stadium[TPSSDataSourceDictKeyStadiumTime];
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
  
  self.navigationItem.rightBarButtonItem = shareButton;
}

- (IBAction)detailButtonClicked:(id)sender {
  NSInteger tag = ((UIButton*)sender).tag;
  
  if ( tag == 1 ) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TPSSDetailInformationViewController *detailInformationViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailInformation"];
    [detailInformationViewController setDetailTitle:@"運動項目" Banner:self.stadiumImage.image andContent:[self sportsInStadium]];
    [self.navigationController pushViewController:detailInformationViewController animated:YES];
  }
  else if ( tag == 2 ) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TPSSDetailInformationViewController *detailInformationViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailInformation"];
    [detailInformationViewController setDetailTitle:@"交通信息" Banner:self.stadiumImage.image andContent:[[NSString alloc ]initWithFormat:@"公車路線:\n%@\n捷運路線:\n%@",stadium[TPSSDataSourceDictKeyStadiumBus],stadium[TPSSDataSourceDictKeyStadiumMrt]]];
    [self.navigationController pushViewController:detailInformationViewController animated:YES];
  }
}

- (void) share:(id)sender {
  SLComposeViewController *composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
  [composer setInitialText:@"台北運動星"];
  
  composer.completionHandler = ^(SLComposeViewControllerResult result) {
    if (result==SLComposeViewControllerResultDone) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"發送成功"
                                                          message:nil
                                                         delegate:nil
                                                cancelButtonTitle:@"知道了"
                                                otherButtonTitles:nil];
      [alertView show];
    }
  };
   
  [self presentViewController:composer animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) sportsInStadium {
  NSArray *sports = [stadium[TPSSDataSourceDictKeyStadiumSports] allValues];
  NSMutableArray *sportNames = [[NSMutableArray alloc]init];
  for ( NSDictionary* sport in sports ) {
    [sportNames addObject:sport[TPSSDataSourceDictKeySportName]];
  }
  return [sportNames componentsJoinedByString:@","];
}

@end
