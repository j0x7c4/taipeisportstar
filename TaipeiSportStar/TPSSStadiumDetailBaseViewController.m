//
//  TPSSStadiumDetailBaseViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailBaseViewController.h"
#import "TPSSDataSource.h"

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
  self.labelBusInfo.text = [[NSString alloc]initWithFormat:@"公車路線:%@",stadium[TPSSDataSourceDictKeyStadiumBus]];
  self.labelMRTInfo.text = [[NSString alloc]initWithFormat:@"捷運路線:%@",stadium[TPSSDataSourceDictKeyStadiumMrt]];
  self.labelOpenTime.text = stadium[TPSSDataSourceDictKeyStadiumTime];
  self.labelSports.text = [[NSString alloc]initWithFormat:@"運動項目:%@",[self sportsInStadium] ];
	// Do any additional setup after loading the view.
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
