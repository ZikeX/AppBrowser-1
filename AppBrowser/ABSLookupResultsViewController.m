//
//  ABSLookupResultsViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSLookupResultsViewController.h"
#import "ABSLookupResultsViewModel.h"

@interface ABSLookupResultsViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ABSLookupResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.containerView.hidden = YES;
    
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    tabBarController.tabBar.hidden = NO;
    
    [super viewWillDisappear:animated];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    NSString *text = searchBar.text;
    
    [self showLoadingView];
    
    @weakify(self);
    [[self.viewModel
      searchBarSearchButtonClicked:text]
      subscribeNext:^(NSString *HTMLString) {
          @strongify(self);
          if (HTMLString) {
              [self showResultsViewWithHTMLString:HTMLString];
          } else {
              [self showNoResultsViewWithText:text];
          }
      } error:^(NSError * _Nullable error) {
          [self showNoResultsViewWithText:text];
      }];
}

- (void)showLoadingView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.containerView.hidden = NO;
        self.indicatorView.hidden = NO;
        self.textLabel.hidden = YES;
        self.webView.hidden = YES;
        
        [self.indicatorView startAnimating];
    });
}

- (void)showResultsViewWithHTMLString:(NSString *)HTMLString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.containerView.hidden = NO;
        self.indicatorView.hidden = YES;
        self.textLabel.hidden = YES;
        self.webView.hidden = NO;
        
        [self.webView loadHTMLString:HTMLString baseURL:nil];
    });
}

- (void)showNoResultsViewWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.containerView.hidden = NO;
        self.indicatorView.hidden = YES;
        self.textLabel.hidden = NO;
        self.webView.hidden = YES;
        
        self.textLabel.text = [NSString stringWithFormat:@"%@ \"%@\"", NSLocalizedString(@"No results for", @""), text];
    });
}

@end
