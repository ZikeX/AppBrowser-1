//
//  ABSFilterViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSFilterViewModel.h"

#import "ABSItunesAppInfo.h"
#import "ABSLocalAppInfo.h"

@interface ABSFilterViewModel ()

@property (assign, nonatomic) ABSFilterType filterType;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSMutableArray *whiteList;

@end

@implementation ABSFilterViewModel

- (instancetype)initWithFilterType:(ABSFilterType)type
{
    self = [super init];
    if (self) {
        _filterType = type;
        
        if (type == ABSItunesResultFilter) {
            _keys = [ABSItunesAppInfo allKeys];
            _whiteList = [[NSMutableArray alloc] initWithArray:[ABSItunesAppInfo displayKeys]];
        } else {
            _keys = [ABSLocalAppInfo allKeys];
            _whiteList = [[NSMutableArray alloc] initWithArray:[ABSLocalAppInfo displayKeys]];
        }
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.keys.count;
}

- (NSString *)textAtIndexPath:(NSIndexPath *)indexPath
{
    return self.keys[indexPath.row];
}

- (BOOL)showCheckmarkAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.keys[indexPath.row];
    return [self.whiteList containsObject:key];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.keys[indexPath.row];
    if ([self.whiteList containsObject:key]) {
        [self.whiteList removeObject:key];
    } else {
        [self.whiteList addObject:key];
    }
}

- (void)save
{
    if (self.filterType == ABSItunesResultFilter) {
        [ABSItunesAppInfo saveDisplayKeys:self.whiteList];
    } else {
        [ABSLocalAppInfo saveDisplayKeys:self.whiteList];
    }
}

@end
