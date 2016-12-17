//
//  ABSLookupResultsViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSLookupResultsViewModel.h"
#import "ABSItunesAppInfo.h"
#import "NSURLSession+AppBrowser.h"

@implementation ABSLookupResultsViewModel

- (RACSignal *)searchBarSearchButtonClicked:(NSString *)text
{
    NSString *trackId = text;
    if ([text hasPrefix:@"https://itunes.apple.com/"]) {
        NSString *pathComponent = [NSURL URLWithString:text].pathComponents.lastObject;
        if ([pathComponent hasPrefix:@"id"]) {
            trackId = [pathComponent substringFromIndex:2];
        }
    }
    
    NSString *URLString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", trackId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    @weakify(self);
    return [[[[NSURLSession
              abs_sendAsynchronousRequest:request]
              reduceEach:^id (NSURLResponse *response, NSData *data) {
                  return data;
              }]
              map:^id (NSData *data) {
                  ABSItunesAppInfo *appInfo = nil;
                  if (data) {
                      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                      if (dict) {
                          NSArray *results = dict[@"results"];
                          if (results && results.count == 1) {
                              appInfo = [[ABSItunesAppInfo alloc] initWithDictionary:results[0]];
                          }
                      }
                  }
                  return appInfo;
              }]
              map:^id (ABSItunesAppInfo *appInfo) {
                  @strongify(self);
                  return [self HTMLStringWithAppInfo:appInfo];
              }];
}

- (NSString *)HTMLStringWithAppInfo:(ABSItunesAppInfo *)appInfo
{
    if (appInfo) {
        [self addLookupHistoryWithAppInfo:appInfo];
        
        return [NSString stringWithFormat:@"%@%@%@", [self HTMLHeaderString], [self HTMLBodyStringWithAppInfo:appInfo], [self HTMLFooterString]];
    } else {
        return nil;
    }
}

- (void)addLookupHistoryWithAppInfo:(ABSItunesAppInfo *)appInfo
{
    NSString *trackId = appInfo.trackId;
    NSString *trackName = appInfo.trackName;
    if (trackId.length > 0 && trackName.length > 0) {
        NSArray *history = [[NSUserDefaults standardUserDefaults] objectForKey:@"LookupHistory"] ?: @[];
        for (NSDictionary *dict in history) {
            if ([dict[@"trackId"] isEqualToString:trackId]) {
                return;
            }
        }
        
        NSDictionary *dict = @{ @"trackId": trackId, @"trackName": trackName };
        NSMutableArray *newHistory = [history mutableCopy];
        [newHistory insertObject:dict atIndex:0];
        
        if (newHistory.count > 5) {
            [newHistory removeLastObject];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newHistory forKey:@"LookupHistory"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)HTMLBodyStringWithAppInfo:(ABSItunesAppInfo *)appInfo
{
    NSDictionary *dict = appInfo.dictionary;
    NSArray *whiteList = [ABSItunesAppInfo displayKeys];
    
    return [[[[[[dict.allKeys
                 rac_sequence]
                filter:^BOOL(NSString *key) {
                    return [whiteList containsObject:key];
                }]
               map:^id (NSString *key) {
                   NSString *value = [dict[key] description];
                   return [NSString stringWithFormat:@"<div class=\"divTableRow\"><div class=\"divTableCell\">%@</div><div class=\"divTableCell\">%@</div></div>", key, value];
               }]
              scanWithStart:@""
              reduce:^NSString *(NSString *running, NSString *next) {
                  NSString *str = [NSString stringWithFormat:@"%@%@", running, next];
                  return str;
              }]
             array] lastObject];
}

- (NSString *)HTMLHeaderString
{
    NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"html"];
    return [NSString stringWithContentsOfFile:headerPath encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)HTMLFooterString
{
    NSString *footerPath = [[NSBundle mainBundle] pathForResource:@"footer" ofType:@"html"];
    return [NSString stringWithContentsOfFile:footerPath encoding:NSUTF8StringEncoding error:nil];
}

@end
