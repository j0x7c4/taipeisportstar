//
//  TPSSDetailInformationViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSDetailInformationViewController : UIViewController
-(id)initWithDetailTitle:(NSString *) title Banner:(UIImage*) banner andContent:(NSString*)content;
-(void)setDetailTitle:(NSString *) title Banner:(UIImage*) banner andContent:(NSString*)content;

@end
