//
//  TPSSStadiumDetailInJoinViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSStadiumDetailInJoinViewController : UIViewController <UITableViewDataSource,
                                                                     UITableViewDelegate>

- (void)setWithStadiumDictionary:(NSDictionary *)stadiumDict;

@end
