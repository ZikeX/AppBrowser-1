//
//  ABSAppViewModel.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "RVMViewModel.h"

@class ABSLocalAppInfo;

@interface ABSAppViewModel : RVMViewModel

- (instancetype)initWithLocalAppInfo:(ABSLocalAppInfo *)appInfo;

- (NSString *)HTMLString;

@end
