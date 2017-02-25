//
//  ABSAppsViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppsViewModel.h"
#import "ABSAppViewModel.h"
#import "ABSLocalAppInfo.h"

@interface ABSAppsViewModel ()

@property (strong, nonatomic, readwrite) RACSignal *updatedContentSignal;
@property (strong, nonatomic, readwrite) RACCommand *refreshCommand;
@property (strong, nonatomic) NSArray *appInfos;
@property (strong, nonatomic) NSArray *searchedAppInfos;

@property (strong, nonatomic) NSCache *imageCache;

@end

@implementation ABSAppsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageCache = [NSCache new];
        _imageCache.countLimit = 500;
        
        self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"-updatedContentSignal: %@", self];
        
        @weakify(self)
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self fetchAllInstalledApps];
        }];
        
        self.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self fetchAllInstalledApps];
            return [RACSignal empty];
        }];
        
        RACChannelTerminal *showSystemAppsChannelTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:@"ShowSystemApps"];
        [showSystemAppsChannelTerminal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self fetchAllInstalledApps];
        }];
        
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section isSearchActive:(BOOL)active
{
    return active ? self.searchedAppInfos.count : self.appInfos.count;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath isSearchActive:(BOOL)active
{
    ABSLocalAppInfo *appInfo = active ? self.searchedAppInfos[indexPath.row] : self.appInfos[indexPath.row];
    return appInfo.localizedName;
}

- (RACSignal *)iconImageAtIndexPath:(NSIndexPath *)indexPath isSearchActive:(BOOL)active;
{
    ABSLocalAppInfo *appInfo = active ? self.searchedAppInfos[indexPath.row] : self.appInfos[indexPath.row];

    NSCache *cache = self.imageCache;
    NSString *key = appInfo.applicationIdentifier;
    
    return [[[RACSignal
             createSignal:^(id<RACSubscriber> subscriber) {
                 __block UIImage *cachedImage = [cache objectForKey:key];
                 if (cachedImage) {
                     [subscriber sendNext:cachedImage];
                     [subscriber sendCompleted];
                 } else {
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         cachedImage = appInfo.iconImage;
                         [cache setObject:cachedImage forKey:key];
                                                  
                         [subscriber sendNext:cachedImage];
                         [subscriber sendCompleted];
                     });
                 }
                 
                 return [RACDisposable disposableWithBlock:^{
                     // pass
                 }];
             }]
            setNameWithFormat:@"+abs_iconImageAtIndexPath:%@ isSearchActive:%@", indexPath, @(active)]
            deliverOnMainThread];
}

- (ABSAppViewModel *)appViewModelAtIndexPath:(NSIndexPath *)indexPath isSearchActive:(BOOL)active
{
    ABSLocalAppInfo *appInfo = active ? self.searchedAppInfos[indexPath.row] : self.appInfos[indexPath.row];
    return [[ABSAppViewModel alloc] initWithLocalAppInfo:appInfo];
}

- (void)updateSearchResultsForSearchText:(NSString *)text
{
    self.searchedAppInfos = [[[self.appInfos rac_sequence] filter:^BOOL(ABSLocalAppInfo *appInfo) {
        return [appInfo.localizedName rangeOfString:text].location != NSNotFound;
    }] array];
    
    [(RACSubject *)self.updatedContentSignal sendNext:nil];
}

#pragma mark - Private
         
- (void)fetchAllInstalledApps
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Class LSApplicationWorkspaceClass = NSClassFromString(@"LSApplicationWorkspace");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        id workspace = [LSApplicationWorkspaceClass performSelector:@selector(defaultWorkspace)];
        NSArray *appProxys = [workspace performSelector:@selector(allInstalledApplications)];
#pragma clang diagnostic pop
        
        BOOL showSystemApps = [[NSUserDefaults standardUserDefaults] boolForKey:@"ShowSystemApps"];
        
        NSMutableArray *array = [[[[[appProxys
            rac_sequence]
            map:^id (id appProxy) {
                return [[ABSLocalAppInfo alloc] initWithAppProxy:appProxy];
            }]
            filter:^BOOL(ABSLocalAppInfo *appInfo) {
                return showSystemApps ? YES : ![appInfo.applicationIdentifier hasPrefix:@"com.apple"];
            }]
            array] mutableCopy];
        
        [array sortUsingComparator:^NSComparisonResult(ABSLocalAppInfo *info1, ABSLocalAppInfo *info2) {
            return [info1.localizedName compare:info2.localizedName];
        }];
        
        self.appInfos = [array copy];
        
        [(RACSubject *)self.updatedContentSignal sendNext:nil];
    });
}

@end
