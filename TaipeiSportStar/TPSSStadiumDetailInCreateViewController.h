//
//  TPSSStadiumDetailInCreateViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSSStadiumDetailBaseViewController.h"

@interface TPSSStadiumDetailInCreateViewController : TPSSStadiumDetailBaseViewController <
UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


- (void)setSelectedSport:(NSDictionary*)sport;
@end
