//
//  NSURLSession+AppBrowser.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession (AppBrowser)

+ (RACSignal<RACTuple *> *)abs_sendAsynchronousRequest:(NSURLRequest *)request;

@end
