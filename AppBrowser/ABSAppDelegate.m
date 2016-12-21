//
//  AppDelegate.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppDelegate.h"

#import "ABSLookupViewController.h"
#import "ABSAppsViewController.h"
#import "ABSSettingsViewController.h"

#import "ABSLookupViewModel.h"
#import "ABSAppsViewModel.h"
#import "ABSSettingsViewModel.h"

@interface ABSAppDelegate ()

@end

@implementation ABSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    for (UINavigationController *navigationController in tabBarController.viewControllers) {
        UIViewController *topViewController = navigationController.topViewController;
        if ([topViewController isKindOfClass:[ABSLookupViewController class]]) {
            ABSLookupViewController *lookupViewController = (ABSLookupViewController *)topViewController;
            lookupViewController.viewModel = [[ABSLookupViewModel alloc] init];
        } else if ([topViewController isKindOfClass:[ABSAppsViewController class]]) {
            ABSAppsViewController *appsViewController = (ABSAppsViewController *)topViewController;
            appsViewController.viewModel = [[ABSAppsViewModel alloc] init];
        } else if ([topViewController isKindOfClass:[ABSSettingsViewController class]]) {
            ABSSettingsViewController *settingsViewController = (ABSSettingsViewController *)topViewController;
            settingsViewController.viewModel = [[ABSSettingsViewModel alloc] init];
        } else {
            // pass
        }
    }
    
    return YES;
}

@end
