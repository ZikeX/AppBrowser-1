//
//  ABSLookupViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSLookupViewModel.h"

#import "ABSLookupResultsViewModel.h"

@interface ABSLookupViewModel ()

@property (strong, nonatomic, readwrite) RACSignal *updatedContentSignal;
@property (strong, nonatomic) NSArray *lookupHistory;

@end

@implementation ABSLookupViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"-updatedContentSignal: %@", self];
        
        @weakify(self)
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self fetchLookupHistory];
        }];
        
        RACChannelTerminal *showSystemAppsChannelTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:@"LookupHistory"];
        [showSystemAppsChannelTerminal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self fetchLookupHistory];
        }];
    }
    return self;
}

- (NSInteger)numbersOfHistoryButton
{
    return self.lookupHistory.count;
}

- (NSString *)titleForHistoryButtonAtIndex:(NSInteger)index
{
    NSString *trackName = self.lookupHistory[index][@"trackName"];
    if ([trackName rangeOfString:@"－"].location != NSNotFound) {
         return [[trackName componentsSeparatedByString:@"－"] firstObject];
    } else if ([trackName rangeOfString:@"-"].location != NSNotFound) {
        return [[trackName componentsSeparatedByString:@"-"] firstObject];
    } else {
        return trackName;
    }
}

- (NSString *)identifyForHistoryButtonAtIndex:(NSInteger)index
{
    return self.lookupHistory[index][@"trackId"];
}

- (ABSLookupResultsViewModel *)lookupResultsViewModel
{
    return [[ABSLookupResultsViewModel alloc] init];
}

#pragma mark - Private

- (void)fetchLookupHistory
{
    self.lookupHistory = [[NSUserDefaults standardUserDefaults] objectForKey:@"LookupHistory"] ?: @[];
    [(RACSubject *)self.updatedContentSignal sendNext:nil];
}

@end
