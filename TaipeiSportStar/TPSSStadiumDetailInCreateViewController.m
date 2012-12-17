//
//  TPSSStadiumDetailInCreateViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSStadiumDetailInCreateViewController.h"
#import "TPSSDataSource.h"
@interface TPSSStadiumDetailInCreateViewController () {
  NSDictionary *stadium;
}
@property (strong, nonatomic) IBOutlet UILabel *labelStadiumName;
@property (strong, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (strong, nonatomic) IBOutlet UILabel *labelSports;
@property (strong, nonatomic) IBOutlet UILabel *labelBusInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelMRTInfo;
@property (strong, nonatomic) IBOutlet UIButton *buttonCreateEvent;

@end

@implementation TPSSStadiumDetailInCreateViewController

- (IBAction)createEvent:(id)sender {

}

- (void) setWithStadiumDictionary:(NSDictionary *)stadiumDict {
    stadium = stadiumDict;
}

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
  
  self.title = self.labelStadiumName.text = stadium[TPSSDataSourceDictKeyStadiumName];
  self.labelBusInfo.text = [[NSString alloc]initWithFormat:@"公車路線:%@",stadium[TPSSDataSourceDictKeyStadiumBus]];
  self.labelMRTInfo.text = [[NSString alloc]initWithFormat:@"捷運路線:%@",stadium[TPSSDataSourceDictKeyStadiumMrt]];
  self.labelOpenTime.text = stadium[TPSSDataSourceDictKeyStadiumTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
