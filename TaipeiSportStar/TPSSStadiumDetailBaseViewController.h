//
//  TPSSStadiumDetailBaseViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSSDataSource.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <Accounts/ACAccount.h>
#import <Accounts/ACAccountStore.h>
#import <Accounts/ACAccountType.h>
@interface TPSSStadiumDetailBaseViewController : UIViewController <UINavigationBarDelegate> {
  NSDictionary *stadium;
}
@property (strong, nonatomic) IBOutlet UILabel *labelStadiumName;
@property (strong, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (strong, nonatomic) IBOutlet UIImageView *stadiumImage;
@property (strong, nonatomic) IBOutlet UIButton *sportDetailButton;
@property (strong, nonatomic) IBOutlet UIButton *trafficDetailButton;


- (IBAction)detailButtonClicked:(id)sender;

- (void)setWithStadiumDictionary:(NSDictionary *)stadiumDict;
- (NSString*) sportsInStadium;
@end
