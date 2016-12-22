//
//  ABSSettingsViewModel.h
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "RVMViewModel.h"

@interface ABSSettingsViewModel : RVMViewModel

@property (assign, nonatomic) BOOL isSystemAppsOn;

- (void)showSystemApp:(BOOL)on;

- (void)clearLookupHistory;

- (NSString *)clearHistoryActionSheetMessage;
- (NSString *)clearActionTittle;
- (NSString *)canceActionlTitle;

@end
