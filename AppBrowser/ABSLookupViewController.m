//
//  ABSLookupViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSLookupViewController.h"
#import "ABSLookupResultsViewController.h"

#import "ABSLookupViewModel.h"
#import "ABSLookupResultsViewModel.h"

@interface ABSLookupViewController () 

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) ABSLookupResultsViewController *lookupResultsViewController;
@property (weak, nonatomic) IBOutlet UIView *noHistoryView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ABSLookupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.lookupResultsViewController = [storyboard instantiateViewControllerWithIdentifier:@"ABSLookupResultsViewController"];;
    self.lookupResultsViewController.viewModel = [self.viewModel lookupResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.lookupResultsViewController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.definesPresentationContext = YES;
    
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.tag = 89757; // hack for not show cancel button
    self.searchController.searchBar.delegate = self.lookupResultsViewController;
    self.navigationItem.titleView = self.searchController.searchBar;
    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

- (void)reloadData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger count = [self.viewModel numbersOfHistoryButton];
        if (count > 0) {
            self.noHistoryView.hidden = YES;
            self.historyView.hidden = NO;
            
            for (UIView *subview in self.stackView.arrangedSubviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    [self.stackView removeArrangedSubview:subview];
                }
            }
            
            for (NSInteger i = 0; i < count; i++) {
                NSString *title = [self.viewModel titleForHistoryButtonAtIndex:i];
                UIButton *button = [self buttonForTitle:title index:i];
                [self.stackView addArrangedSubview:button];
            }
            
        } else {
            self.noHistoryView.hidden = NO;
            self.historyView.hidden = YES;
        }
    });
}

- (UIButton *)buttonForTitle:(NSString *)title index:(NSInteger)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = index;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)didTapButton:(UIButton *)button
{
    NSInteger index = button.tag;
    NSString *identifier = [self.viewModel identifyForHistoryButtonAtIndex:index];
    self.searchController.searchBar.text = identifier;
    
    [self.searchController.searchBar becomeFirstResponder];
    
    [self.lookupResultsViewController performSelector:@selector(searchBarSearchButtonClicked:) withObject:self.searchController.searchBar];    
}

@end
