//
//  ABSAppViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppViewController.h"
#import "ABSAppViewModel.h"

@interface ABSAppViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation ABSAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [self.webView loadHTMLString:[self.viewModel HTMLString] baseURL:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showIndicatorView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self dismissIndicatorView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self dismissIndicatorView];
}

- (void)showIndicatorView
{
    self.navigationController.view.userInteractionEnabled = NO;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)dismissIndicatorView
{
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
    self.navigationController.view.userInteractionEnabled = YES;
}

@end
