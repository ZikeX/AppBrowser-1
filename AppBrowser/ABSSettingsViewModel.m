//
//  ABSSettingsViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSSettingsViewModel.h"

@implementation ABSSettingsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isSystemAppsOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"ShowSystemApps"];
    }
    return self;
}

- (void)showSystemApp:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:@"ShowSystemApps"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearLookupHistory
{
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"LookupHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)clearHistoryActionSheetMessage
{
    return NSLocalizedString(@"Sure to clear lookup history?", @"");
}

- (NSString *)clearActionTittle
{
    return NSLocalizedString(@"Clear", @"");
}

- (NSString *)canceActionlTitle
{
    return NSLocalizedString(@"Cancel", @"");
}

@end
