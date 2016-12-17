//
//  ABSLookupViewModel.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "RVMViewModel.h"

@class ABSLookupResultsViewModel;

@interface ABSLookupViewModel : RVMViewModel

@property (strong, nonatomic, readonly) RACSignal *updatedContentSignal;

- (NSInteger)numbersOfHistoryButton;
- (NSString *)titleForHistoryButtonAtIndex:(NSInteger)index;
- (NSString *)identifyForHistoryButtonAtIndex:(NSInteger)index;

- (ABSLookupResultsViewModel *)lookupResultsViewModel;

@end
