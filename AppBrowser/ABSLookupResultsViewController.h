//
//  ABSLookupResultsViewController.h
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABSLookupResultsViewModel;

@interface ABSLookupResultsViewController : UIViewController <UISearchBarDelegate>

@property (strong, nonatomic) ABSLookupResultsViewModel *viewModel;

@end
