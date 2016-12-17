//
//  ABSFilterViewModel.h
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "RVMViewModel.h"

typedef NS_ENUM(NSUInteger, ABSFilterType) {
    ABSItunesResultFilter,
    ABSLocalAppInfoFilter
};

@interface ABSFilterViewModel : RVMViewModel

- (instancetype)initWithFilterType:(ABSFilterType)type;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)textAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)showCheckmarkAtIndexPath:(NSIndexPath *)indexPath;

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)save;

@end
