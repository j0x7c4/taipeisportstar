//
//  TPSSFriendListViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/26/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSFriendListViewController : UITableViewController <UISearchBarDelegate>{
  NSMutableArray *_selFlags;
}
- (void) setEventId: (NSString*) eventId;
@end
