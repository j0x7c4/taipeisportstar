//
//  TPSSStadiumDetailInCreateViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSStadiumDetailInCreateViewController : UIViewController <
UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

- (void)setWithStadiumDictionary:(NSDictionary *)stadiumDict;
- (void)setSelectedSport:(NSDictionary*)sport;
@end
