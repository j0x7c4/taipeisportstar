//
//  TPSSDetailInformationViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSDetailInformationViewController.h"

@interface TPSSDetailInformationViewController () {
  UIImage* infoBanner;
  NSString* infoContent;
  NSString* infoTitle;
}
@property (strong, nonatomic) IBOutlet UIImageView *bannerImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentText;

@end

@implementation TPSSDetailInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDetailTitle:(NSString *) title Banner:(UIImage*) banner andContent:(NSString*)content {
  if ( self = [super init] ) {
    infoBanner  = banner;
    infoContent = content;
    infoTitle = title;
  }
  return self;
}
-(void)setDetailTitle:(NSString *) title Banner:(UIImage*) banner andContent:(NSString*)content {
  infoBanner  = banner;
  infoContent = content;
  infoTitle = title;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.bannerImage.image = infoBanner;
  self.title = infoTitle;
  self.contentText.text = infoContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
