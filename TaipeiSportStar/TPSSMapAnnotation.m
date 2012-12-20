//
//  TPSSMapAnnotation.m
//  TaipeiSportStar
//
//  Created by Jie on 12/13/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSMapAnnotation.h"
#import "TPSSDataSource.h"

@interface TPSSMapAnnotation() 

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@property (nonatomic, readwrite, copy) NSString *title;


@end

@implementation TPSSMapAnnotation
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;
- (id)initWithStadiumID:(NSString *) Id
          coordinate:(CLLocationCoordinate2D)coord
             andName:(NSString *)name {
  if (self = [super init]) {
    _stadiumID = Id;
    _coordinate = coord;
    _title = name;
  }
  return self;
  
}

- (id)initWithStadiumDictionary:(NSDictionary *)stadiumDict {
  NSString *stadiumID = stadiumDict[TPSSDataSourceDictKeyStadiumID];
  CLLocationDegrees lat = [stadiumDict[TPSSDataSourceDictKeyStadiumLatitude] doubleValue];
  CLLocationDegrees lng = [stadiumDict[TPSSDataSourceDictKeyStadiumLongitude] doubleValue];
  //NSLog(@"%lf %lf\n",lat,lng);
  
  CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
  NSString *name = stadiumDict[TPSSDataSourceDictKeyStadiumName];
  
  if (self = [self initWithStadiumID:stadiumID coordinate:coord andName:name]) {
    //NSLog(@"%@ %@",stadiumID,name);
  }
  return self;
}


+ (NSArray *)arrayWithStadiums:(NSArray*) stadiums {
  NSMutableArray* result = [[NSMutableArray alloc]init];
  for (NSDictionary *stadium in stadiums) {
    //NSLog(@"----%@",stadium[TPSSDataSourceDictKeyStadiumName]);
    TPSSMapAnnotation *mark = [[TPSSMapAnnotation alloc] initWithStadiumDictionary:stadium];
    [result addObject:mark];
  }
  return result;
}
@end
