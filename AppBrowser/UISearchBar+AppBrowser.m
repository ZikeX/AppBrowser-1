//
//  UISearchBar+AppBrowser.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "UISearchBar+AppBrowser.h"
#import <objc/runtime.h>

static void abs_exchangeInstanceMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}

@implementation UISearchBar (AppBrowser)

static NSArray *abs_tags;

+ (void)load
{
    [self abs_notShowCancelButtonForTags:@[@(89757)]];
}

+ (void)abs_notShowCancelButtonForTags:(NSArray *)tags
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        abs_tags = tags ?: @[];
        abs_exchangeInstanceMethod([self class], @selector(setShowsCancelButton:animated:), @selector(abs_setShowsCancelButton:animated:));
    });
}

- (void)abs_setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated
{
    if ([abs_tags containsObject:@(self.tag)]) {
        // pass
    } else {
        [self abs_setShowsCancelButton:showsCancelButton animated:animated];
    }
}

@end
