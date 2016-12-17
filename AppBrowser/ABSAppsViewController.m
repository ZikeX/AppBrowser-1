//
//  ABSAppsViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSAppsViewController.h"
#import "ABSAppViewController.h"

#import "ABSAppsViewModel.h"
#import "ABSAppViewModel.h"

@interface ABSAppsViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ABSAppsViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.contentOffset = CGPointMake(0, 44);
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.rac_command = self.viewModel.refreshCommand;
    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section isSearchActive:self.searchController.active];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABSAppCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.viewModel textAtIndexPath:indexPath isSearchActive:self.searchController.active];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ABSAppViewController *appViewController = [storyboard instantiateViewControllerWithIdentifier:@"ABSAppViewController"];
    appViewController.viewModel = [self.viewModel appViewModelAtIndexPath:indexPath isSearchActive:self.searchController.active];
    [self showViewController:appViewController sender:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.viewModel updateSearchResultsForSearchText:searchController.searchBar.text];
}

@end
