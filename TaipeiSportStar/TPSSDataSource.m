//
//  TPSSDataSource.m
//  TaipeiSportStar
//
//  Created by Jie on 12/11/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSDataSource.h"
#import "JSONKit.h"

// Cache Keys
static NSString *TPSSDataSourceCacheKeyAllStadiums = @"TPSSDataSource.Cache.AllStadiums";
static NSString *TPSSDataSourceCacheKeyAllSports = @"TPSSDataSource.Cache.AllSports";
static NSString *TPSSDataSourceCacheKeyStadiumWithID = @"TPSSDataSource.Cache.Stadium.ID.%@";
static NSString *TPSSDataSourceCacheKeySportWithID = @"TPSSDataSource.Cache.Sport.%@";
static NSString *TPSSDataSourceCacheKeyStadiumWithSport = @"TPSSDataSource.Cache.Stadium.Sport.%@";
static NSString *TPSSDataSourceCacheKeyStadiumWithType = @"TPSSDataSource.Cache.Stadium.Type.%@";
static NSString *TPSSDataSourceCacheKeySportWithType = @"TPSSDataSource.Cache.Sport.Type.%@";


// Dictionary Keys
NSString * const TPSSDataSourceDictKeyStadiumID = @"id";
NSString * const TPSSDataSourceDictKeyStadiumName = @"name";
NSString * const TPSSDataSourceDictKeyStadiumAddress = @"address";
NSString * const TPSSDataSourceDictKeyStadiumTime = @"time";
NSString * const TPSSDataSourceDictKeyStadiumSports = @"sport";
NSString * const TPSSDataSourceDictKeyStadiumType = @"type";
NSString * const TPSSDataSourceDictKeyStadiumBus = @"bus";
NSString * const TPSSDataSourceDictKeyStadiumMrt = @"mrt";
NSString * const TPSSDataSourceDictKeyStadiumLatitude = @"lat";
NSString * const TPSSDataSourceDictKeyStadiumLongitude = @"long";
NSString * const TPSSDataSourceDictKeyStadiumImage = @"image";

NSString * const TPSSDataSourceDictKeySportName = @"name";

@implementation TPSSDataSource
+ (TPSSDataSource *)sharedDataSource {
  static dispatch_once_t once;
  static TPSSDataSource *sharedDataSource;
  dispatch_once(&once, ^ {
    sharedDataSource = [[self alloc] init];
  });
  return sharedDataSource;
  
}
- (void)refresh {
  
  [self cleanCache];
  
  
}
- (void)cleanCache {
  
  [cache removeAllObjects];
  
  
}
- (NSDictionary *) stadiumWithID:(NSString *) ID {
  
  NSString *cacheKey = [NSString stringWithFormat:TPSSDataSourceCacheKeyStadiumWithID,ID];
  NSDictionary *resultStadium = [cache objectForKey:cacheKey];
  if ( !resultStadium ) {
    
    NSString *firstString = @"http://taipeisportstar.appspot.com/api/stadiums/id/";
    NSString *secondString = ID;
    NSString *concatinatedString = [firstString stringByAppendingString:secondString];
    
    NSURL *jsonURL = [NSURL URLWithString:concatinatedString];
    
    NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    resultStadium = (NSDictionary *)[data mutableObjectFromJSONData];
    [cache setObject:resultStadium forKey:cacheKey];
    
    
  }
  return resultStadium;
  
  
}
- (NSArray *)arrayWithAllStadiums {
  
  NSArray *stadiums = [cache objectForKey:TPSSDataSourceCacheKeyAllStadiums];
  NSURL *jsonURL = [NSURL URLWithString:@"http://taipeisportstar.appspot.com/api/stadiums/all"];
  NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
  NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *arr=(NSArray *)[data mutableObjectFromJSONData];
  if (!stadiums) {
    // Save cities into a set.
    
    stadiums = arr;
    // Save the result into cache
    [cache setObject:stadiums forKey:TPSSDataSourceCacheKeyAllStadiums];
  }
  
  return stadiums;
  
  
  
}
- (NSArray *)arrayWithAllSports {
  
  NSArray *sports = [cache objectForKey:TPSSDataSourceCacheKeyAllSports];
  NSURL *jsonURL = [NSURL URLWithString:@"http://taipeisportstar.appspot.com/api/sports/all"];
  NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
  NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *arr=(NSArray *)[data mutableObjectFromJSONData];
  if (!sports) {
    
    sports = arr;
    // Save the result into cache
    [cache setObject:sports forKey:TPSSDataSourceCacheKeyAllSports];
  }
  
  return sports;
  
}
- (NSArray *)arrayWithStadiumsBySport:(NSString*) sport {
  
  NSString *cacheKey = [NSString stringWithFormat:TPSSDataSourceCacheKeyStadiumWithSport, sport];
  NSArray *resultStadiums = [cache objectForKey:cacheKey];
  
  if (!resultStadiums){
    
    NSString *firstString = @"http://taipeisportstar.appspot.com/api/stadiums/sport/";
    NSString *secondString = sport;
    NSString *concatinatedString = [firstString stringByAppendingString:secondString];
    
    
    concatinatedString = [concatinatedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *jsonURL = [NSURL URLWithString:concatinatedString];
    
    NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    resultStadiums = (NSArray *)[data mutableObjectFromJSONData];
    [cache setObject:resultStadiums forKey:cacheKey];
    
    
  }
  
  return resultStadiums;
  
}
- (NSArray *)arrayWithStadiumsByType:(NSString*) type {
  
  NSString *cacheKey = [NSString stringWithFormat:TPSSDataSourceCacheKeyStadiumWithType, type];
  NSArray *resultStadiums = [cache objectForKey:cacheKey];
  
  if (!resultStadiums){
    
    NSString *firstString = @"http://taipeisportstar.appspot.com/api/stadiums/type/";
    NSString *secondString = type;
    NSString *concatinatedString = [firstString stringByAppendingString:secondString];
    
    
    NSURL *jsonURL = [NSURL URLWithString:concatinatedString];
    
    NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    resultStadiums = (NSArray *)[data mutableObjectFromJSONData];
    [cache setObject:resultStadiums forKey:cacheKey];
    
    
  }
  
  return resultStadiums;
  
}
- (NSArray *)arrayWithSportsByType:(NSString*) type {
  NSString *cacheKey = [NSString stringWithFormat:TPSSDataSourceCacheKeySportWithType, type];
  NSArray *resultSports = [cache objectForKey:cacheKey];
  
  if (!resultSports){
    
    NSString *firstString = @"http://taipeisportstar.appspot.com/api/sports/type/";
    NSString *secondString = type;
    NSString *concatinatedString = [firstString stringByAppendingString:secondString];
    
    NSURL *jsonURL = [NSURL URLWithString:concatinatedString];
    NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    resultSports = (NSArray *)[data mutableObjectFromJSONData];
    [cache setObject:resultSports forKey:cacheKey];
    
    
  }
  
  return resultSports;
  
}

- (NSArray *)arrayWithStadiumsByEvent {
  NSString *strURL = @"http://taipeisportstar.appspot.com/api/event/select/stadium";
  NSURL *jsonURL = [NSURL URLWithString:strURL];
  NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
  NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *stadiums=(NSArray *)[data mutableObjectFromJSONData];
  return stadiums;
}
- (NSArray *)arrayWithSportsByEvent {
  NSString *strURL = @"http://taipeisportstar.appspot.com/api/event/select/sport";
  NSURL *jsonURL = [NSURL URLWithString:strURL];
  NSString *jsonstring = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
  NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
  NSArray *sports=(NSArray *)[data mutableObjectFromJSONData];
  return sports;
}

@end