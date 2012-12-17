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

@interface TPSSDataSource : NSObject {
  // Cache data pool
  NSCache *cache;
}


+ (TPSSDataSource *)sharedDataSource;
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

@end
