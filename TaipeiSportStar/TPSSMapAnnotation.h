//
//  TPSSMapAnnotation.h
//  TaipeiSportStar
//
//  Created by Jie on 12/13/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TPSSMapAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) NSString* stadiumID;
- (id)initWithStadiumID:(NSString *)stadiumID coordinate:(CLLocationCoordinate2D)coord andName:(NSString *)name;
- (id)initWithStadiumDictionary:(NSDictionary *)stadiumDict;
+ (NSArray *)arrayWithStadiums:(NSArray*) stadiums;
@end
