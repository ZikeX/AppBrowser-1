//
//  ABSSettingsViewController.m
//  AppBrowser
//
//  Created by little2s on 2016/12/17.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSSettingsViewController.h"
#import "ABSFilterViewController.h"

#import "ABSSettingsViewModel.h"
#import "ABSFilterViewModel.h"

@interface ABSSettingsViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *systemAppsSwitch;

@end

@implementation ABSSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.systemAppsSwitch.on = self.viewModel.systemAppsSwitchOn;
    
    RACChannelTo(self.viewModel, systemAppsSwitchOn) = [self.systemAppsSwitch rac_newOnChannel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showFilterViewControllerWithType:ABSItunesResultFilter];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        [self showFilterViewControllerWithType:ABSLocalAppInfoFilter];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [self showClearActionSheet];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showFilterViewControllerWithType:(ABSFilterType)type
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ABSFilterViewController *filterViewController = [storyboard instantiateViewControllerWithIdentifier:@"ABSFilterViewController"];
    filterViewController.viewModel = [[ABSFilterViewModel alloc] initWithFilterType:type];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filterViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)showClearActionSheet
{
    NSString *message = [self.viewModel clearHistoryActionSheetMessage];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(self);
    NSString *clearActionTitle = [self.viewModel clearActionTittle];
    UIAlertAction *clearAction = [UIAlertAction actionWithTitle:clearActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        @strongify(self);
        [self.viewModel clearLookupHistory];
    }];
    [actionSheet addAction:clearAction];
    
    NSString *cancelActionTitle = [self.viewModel canceActionlTitle];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
