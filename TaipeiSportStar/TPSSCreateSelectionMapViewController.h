//
//  TPSSCreateSelectionMapViewController.h
//  TaipeiSportStar
//
//  Created by Jie on 12/6/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>

@interface TPSSCreateSelectionMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, atomic) IBOutlet MKMapView *mapView;

@end
