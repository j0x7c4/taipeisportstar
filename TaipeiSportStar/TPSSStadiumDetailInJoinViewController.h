//
//  TPSSStadiumDetailInJoinViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSStadiumDetailInJoinViewController : UIViewController <UITableViewDataSource,
                                                                     UITableViewDelegate, UIAlertViewDelegate>

- (void)setWithStadiumDictionary:(NSDictionary *)stadiumDict;
- (void)setSelectedEventId:(NSString*)eventId;
@end
