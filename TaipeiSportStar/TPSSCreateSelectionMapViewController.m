//
//  TPSSCreateSelectionMapViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/6/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSCreateSelectionMapViewController.h"
#import "TPSSDataSource.h"
#import "TPSSMapAnnotation.h"
#import "TPSSStadiumDetailInCreateViewController.h"

@interface TPSSCreateSelectionMapViewController ()

@end

@implementation TPSSCreateSelectionMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
  self.mapView.delegate = nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  // Taipei City
  CLLocationCoordinate2D currentCoord = CLLocationCoordinate2DMake(25.01943, 121.5415);
  MKCoordinateRegion initMapRegion = MKCoordinateRegionMakeWithDistance(currentCoord, 3000, 3000);
  [self.mapView setRegion:initMapRegion animated:NO];
  [self.mapView addAnnotations:[TPSSMapAnnotation arrayWithStadiums:[[TPSSDataSource sharedDataSource] arrayWithAllStadiums]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  TPSSMapAnnotation *stadiumAnnotation = view.annotation;
  NSLog(@"%@",stadiumAnnotation.stadiumID);
  NSDictionary* stadium = [[TPSSDataSource sharedDataSource] stadiumWithID:[[NSString alloc]initWithFormat:@"%@",stadiumAnnotation.stadiumID]];
  NSLog(@"%@",stadium);
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  TPSSStadiumDetailInCreateViewController *stadiumDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"stadiumDetailInCreate"];
  [stadiumDetailViewController setWithStadiumDictionary:stadium];
  [self.navigationController pushViewController:stadiumDetailViewController animated:YES];}

@end
