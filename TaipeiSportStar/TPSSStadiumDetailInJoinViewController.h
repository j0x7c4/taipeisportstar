//
//  TPSSStadiumDetailInJoinViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/16/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSSStadiumDetailBaseViewController.h"
@interface TPSSStadiumDetailInJoinViewController : TPSSStadiumDetailBaseViewController <UITableViewDataSource,
                                                                     UITableViewDelegate, UIAlertViewDelegate>

- (void)setSelectedEventId:(NSString*)eventId;
@end
