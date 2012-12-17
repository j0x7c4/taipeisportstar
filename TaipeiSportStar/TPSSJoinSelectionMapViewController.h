//
//  TPSSJoinSelectionInMapViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/5/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>

@interface TPSSJoinSelectionMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
