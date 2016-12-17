//
//  ABSFilterViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSFilterViewController.h"
#import "ABSFilterViewModel.h"

@interface ABSFilterViewController ()

@end

@implementation ABSFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)didTapCancelButtonItem:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSaveButtonItem:(UIBarButtonItem *)sender
{
    [self.viewModel save];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABSFilterCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.viewModel textAtIndexPath:indexPath];
    cell.accessoryType = [self.viewModel showCheckmarkAtIndexPath:indexPath] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = [self.viewModel showCheckmarkAtIndexPath:indexPath] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
