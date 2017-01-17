//
//  ABSLocalAppInfo.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABSLocalAppInfo : NSObject

@property (strong, nonatomic, readonly) NSDictionary *dictionary;

@property (strong, nonatomic, readonly) NSString *applicationIdentifier;
@property (strong, nonatomic, readonly) NSString *localizedName;
@property (strong, nonatomic, readonly) UIImage *iconImage;

- (instancetype)initWithAppProxy:(id)proxy;

+ (NSArray *)allKeys;
+ (NSArray *)displayKeys;
+ (void)saveDisplayKeys:(NSArray *)keys;

@end
