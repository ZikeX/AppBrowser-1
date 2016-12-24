//
//  ABSAppViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppViewController.h"
#import "ABSAppViewModel.h"

@interface ABSAppViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ABSAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadHTMLString:[self.viewModel HTMLString] baseURL:nil];
}

@end
