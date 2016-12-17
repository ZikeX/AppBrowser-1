//
//  NSURLSession+AppBrowser.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "NSURLSession+AppBrowser.h"

@implementation NSURLSession (AppBrowser)

+ (RACSignal<RACTuple *> *)abs_sendAsynchronousRequest:(NSURLRequest *)request
{
    NSCParameterAssert(request != nil);
    
    return [[RACSignal
             createSignal:^(id<RACSubscriber> subscriber) {
                 __block NSURLSessionDataTask *task = nil;
                 task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                     if (response == nil || data == nil) {
                         [subscriber sendError:error];
                     } else {
                         [subscriber sendNext:RACTuplePack(response, data)];
                         [subscriber sendCompleted];
                     }
                 }];
                 [task resume];
                 
                 return [RACDisposable disposableWithBlock:^{
                     [task cancel];
                 }];
             }]
            setNameWithFormat:@"+abs_sendAsynchronousRequest: %@", request];
}

@end
