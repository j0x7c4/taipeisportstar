//
//  TPSSProfileDetailViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/23/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSProfileDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

- (id)initWithUserId:(NSString*)userId;
- (void)setUserId:(NSString*)userId;
@end
