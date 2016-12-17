//
//  ABSAppViewModel.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppViewModel.h"
#import "ABSLocalAppInfo.h"

@interface ABSAppViewModel ()

@property (strong, nonatomic) ABSLocalAppInfo *appInfo;

@end

@implementation ABSAppViewModel

- (instancetype)initWithLocalAppInfo:(ABSLocalAppInfo *)appInfo
{
    self = [super init];
    if (self) {
        _appInfo = appInfo;
    }
    return self;
}

- (NSString *)HTMLString
{
    return [NSString stringWithFormat:@"%@%@%@", [self HTMLHeaderString], [self HTMLBodyString], [self HTMLFooterString]];
}

- (NSString *)HTMLBodyString
{
    NSDictionary *dict = self.appInfo.dictionary;
    NSArray *whiteList = [ABSLocalAppInfo displayKeys];
    
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
