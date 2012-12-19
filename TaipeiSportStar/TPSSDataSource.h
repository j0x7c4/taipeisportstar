//
//  TPSSDataSource.h
//  TaipeiSportStar
//
//  Created by Jie on 12/11/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

// Dictionary Keys
extern NSString * const TPSSDataSourceDictKeyStadiumID;
extern NSString * const TPSSDataSourceDictKeyStadiumName;
extern NSString * const TPSSDataSourceDictKeyStadiumAddress;
extern NSString * const TPSSDataSourceDictKeyStadiumTime;
extern NSString * const TPSSDataSourceDictKeyStadiumSports;
extern NSString * const TPSSDataSourceDictKeyStadiumType;
extern NSString * const TPSSDataSourceDictKeyStadiumBus;
extern NSString * const TPSSDataSourceDictKeyStadiumMrt;
extern NSString * const TPSSDataSourceDictKeyStadiumLatitude;
extern NSString * const TPSSDataSourceDictKeyStadiumLongitude;
extern NSString * const TPSSDataSourceDictKeyStadiumImage;

extern NSString * const TPSSDataSourceDictKeySportName;
extern NSString * const TPSSDataSourceDictKeySportID;

extern NSString * const TPSSDataSourceDictKeyEventID;
extern NSString * const TPSSDataSourceDictKeyEventSport;

extern NSString * const TPSSDataSourceDictKeyWeatherImage;
extern NSString * const TPSSDataSourceDictKeyWeatherImageHeight;
extern NSString * const TPSSDataSourceDictKeyWeatherImageWidth;
extern NSString * const TPSSDataSourceDictKeyWeatherImageUrl;
extern NSString * const TPSSDataSourceDictKeyWeatherLocation;
extern NSString * const TPSSDataSourceDictKeyWeatherImageTime;
extern NSString * const TPSSDataSourceDictKeyWeatherCondition;
extern NSString * const TPSSDataSourceDictKeyWeatherConditionCode;
extern NSString * const TPSSDataSourceDictKeyWeatherConditionTemp;
extern NSString * const TPSSDataSourceDictKeyWeatherConditionText;

@interface TPSSDataSource : NSObject {
  // Cache data pool
  NSCache *cache;
}


+ (TPSSDataSource *)sharedDataSource;
+ (BOOL) createEventWith:(NSString*)eventId:(NSString*)sportId:(NSString*)andStadiumId;
- (void)refresh;
- (void)cleanCache;
- (NSDictionary *) stadiumWithID:(NSString *) ID;
- (NSArray *)arrayWithAllStadiums;
- (NSArray *)arrayWithAllSports;
- (NSArray *)arrayWithStadiumsBySport:(NSString*) sport;
- (NSArray *)arrayWithStadiumsByType:(NSString*) type;
- (NSArray *)arrayWithSportsByType:(NSString*) type;
- (NSArray *)arrayWithStadiumsByEvent;
- (NSArray *)arrayWithSportsByEvent;
- (NSDictionary *) currentWeather;

@end
