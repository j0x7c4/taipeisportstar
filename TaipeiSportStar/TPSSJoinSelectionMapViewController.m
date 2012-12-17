//
//  TPSSJoinSelectionInMapViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/5/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSJoinSelectionMapViewController.h"
#import "TPSSDataSource.h"
#import "TPSSMapAnnotation.h"
#import "TPSSStadiumDetailInJoinViewController.h"

@interface TPSSJoinSelectionMapViewController ()

@end

@implementation TPSSJoinSelectionMapViewController

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
  //NSLog(@"viewDidload");
  CLLocationCoordinate2D currentCoord = CLLocationCoordinate2DMake(25.01943, 121.5415);
  MKCoordinateRegion initMapRegion = MKCoordinateRegionMakeWithDistance(currentCoord, 3000, 3000);
  [self.mapView setRegion:initMapRegion animated:NO];
  [self.mapView addAnnotations:[TPSSMapAnnotation arrayWithStadiums:[[TPSSDataSource sharedDataSource] arrayWithStadiumsByEvent]]];
  
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
    //NSLog(@"%@",annotationIdentifier);
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
  NSArray *stadiums = [[TPSSDataSource sharedDataSource] arrayWithStadiumsByEvent];
  NSPredicate *predicter = [NSPredicate predicateWithFormat:@"id = %@",stadiumAnnotation.stadiumID];
  NSArray* results = [stadiums filteredArrayUsingPredicate:predicter];
  if ( [results count]>0 ) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TPSSStadiumDetailInJoinViewController *stadiumDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"stadiumDetailInJoin"];
    [stadiumDetailViewController setWithStadiumDictionary:results[0]];
    [self.navigationController pushViewController:stadiumDetailViewController animated:YES];
  }
}
@end
