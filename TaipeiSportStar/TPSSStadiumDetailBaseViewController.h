//
//  TPSSStadiumDetailBaseViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSStadiumDetailBaseViewController : UIViewController {
  NSDictionary *stadium;
}
@property (strong, nonatomic) IBOutlet UILabel *labelStadiumName;
@property (strong, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (strong, nonatomic) IBOutlet UILabel *labelSports;
@property (strong, nonatomic) IBOutlet UILabel *labelBusInfo;
@property (strong, nonatomic) IBOutlet UIImageView *stadiumImage;
@property (strong, nonatomic) IBOutlet UILabel *labelMRTInfo;

- (void)setWithStadiumDictionary:(NSDictionary *)stadiumDict;
- (NSString*) sportsInStadium;
@end
