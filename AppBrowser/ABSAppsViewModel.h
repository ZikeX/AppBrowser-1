//
//  ABSAppsViewModel.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "RVMViewModel.h"

@class ABSAppViewModel;

@interface ABSAppsViewModel : RVMViewModel

@property (strong, nonatomic, readonly) RACSignal *updatedContentSignal;
@property (strong, nonatomic, readonly) RACCommand *refreshCommand;

- (NSInteger)numberOfRowsInSection:(NSInteger)section isSearchActive:(BOOL)active;
- (NSString *)textAtIndexPath:(NSIndexPath *)indexPath isSearchActive:(BOOL)active;

- (ABSAppViewModel *)appViewModelAtIndexPath:(NSIndexPath *)indexPath isSearchActive:(BOOL)active;

- (void)updateSearchResultsForSearchText:(NSString *)text;

@end
