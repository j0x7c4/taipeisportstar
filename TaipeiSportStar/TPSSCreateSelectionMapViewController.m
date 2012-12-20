//
//  TPSSCreateSelectionMapViewController.m
//  TaipeiSportStar
//
//  Created by Jie on 12/6/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSCreateSelectionMapViewController.h"
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
