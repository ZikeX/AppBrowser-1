//
//  ABSItunesAppInfo.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABSItunesAppInfo : NSObject

@property (strong, nonatomic, readonly) NSDictionary *dictionary;
@property (strong, nonatomic, readonly) NSString *bundleId;
@property (strong, nonatomic, readonly) NSString *trackName;
@property (strong, nonatomic, readonly) NSString *trackId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)allKeys;
+ (NSArray *)displayKeys;
+ (void)saveDisplayKeys:(NSArray *)keys;

@end
