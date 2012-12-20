//
//  TPSSJoinSelectionInMapViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/5/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSJoinSelectionMapViewController.h"
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


- (void)viewDidLoad
{
  [super viewDidLoad];
	
  CLLocationCoordinate2D currentCoord = CLLocationCoordinate2DMake(25.01943, 121.5415);
  MKCoordinateRegion initMapRegion = MKCoordinateRegionMakeWithDistance(currentCoord, 3000, 3000);
  [self.mapView setRegion:initMapRegion animated:NO];
  [self.mapView addAnnotations:[TPSSMapAnnotation arrayWithStadiums:[[TPSSDataSource sharedDataSource] arrayWithStadiumsByEvent]]];
  
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
