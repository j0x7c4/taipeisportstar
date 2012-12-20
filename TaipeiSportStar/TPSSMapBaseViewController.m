//
//  TPSSMapBaseViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/20/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSMapBaseViewController.h"

@interface TPSSMapBaseViewController ()

@end

@implementation TPSSMapBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  self.mapView.delegate = nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  // If it's the user location, just return nil.
  if ([annotation isKindOfClass:[MKUserLocation class]])
    return nil;
  
  // Handle any custom annotations.
  if ([annotation isKindOfClass:[TPSSMapAnnotation class]])
  {
    NSString* annotationIdentifier = [[NSString alloc] initWithFormat:@"CustomPinAnnotationView.%@",((TPSSMapAnnotation*)annotation).stadiumID];
    NSLog(@"%@",annotationIdentifier);
    // Try to dequeue an existing pin view first.
    MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                             dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView)
    {
      // If an existing pin view was not available, create one.
      pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                reuseIdentifier:annotationIdentifier];
      pinView.pinColor = MKPinAnnotationColorPurple;
      pinView.animatesDrop = YES;
      pinView.canShowCallout = YES;
      
      // Add a detail disclosure button to the callout.
      pinView.rightCalloutAccessoryView = [UIButton buttonWithType:
                                           UIButtonTypeDetailDisclosure];
    }
    else
      pinView.annotation = annotation;
    
    return pinView;
  }
  
  return nil;
}


@end
