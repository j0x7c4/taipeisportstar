//
//  TPSSMapBaseViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "TPSSDataSource.h"
#import "TPSSMapAnnotation.h"

@interface TPSSMapBaseViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
