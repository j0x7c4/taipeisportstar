//
//  TPSSMultiSelectTableViewCell.h
//  TaipeiSportStar
//
//  Created by Jie on 12/27/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSMultiSelectTableViewCell : UITableViewCell {
  UIImageView * _mSelectedIndicator;
  BOOL          _mSelected;
}

@property (nonatomic, assign) BOOL mSelected;

-(void)changeMSelectedState;

@end
