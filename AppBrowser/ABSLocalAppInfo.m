//
//  ABSLocalAppInfo.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSLocalAppInfo.h"

@interface ABSLocalAppInfo ()

@property (strong, nonatomic, readwrite) NSDictionary *dictionary;

@end

@implementation ABSLocalAppInfo

- (instancetype)initWithAppProxy:(id)proxy
{
    self = [super init];
    if (self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        id applicationIdentifier = [self valueForProxy:proxy selector:@selector(applicationIdentifier)];
        id bundleVersion = [self valueForProxy:proxy selector:@selector(bundleVersion)];
        id teamID = [self valueForProxy:proxy selector:@selector(teamID)];
        id groupIdentifiers = [self valueForProxy:proxy selector:@selector(groupIdentifiers)];
        id originalInstallType = [self valueForProxy:proxy selector:@selector(originalInstallType)];
        id installType = [self valueForProxy:proxy selector:@selector(installType)];
        id iconStyleDomain = [self valueForProxy:proxy selector:@selector(iconStyleDomain)];
        id localizedShortName = [self valueForProxy:proxy selector:@selector(localizedShortName)];
        id localizedName = [self valueForProxy:proxy selector:@selector(localizedName)];
        id privateDocumentTypeOwner = [self valueForProxy:proxy selector:@selector(privateDocumentTypeOwner)];
        id privateDocumentIconNames = [self valueForProxy:proxy selector:@selector(privateDocumentIconNames)];
        id resourcesDirectoryURL = [self valueForProxy:proxy selector:@selector(resourcesDirectoryURL)];
        id installProgress = [self valueForProxy:proxy selector:@selector(installProgress)];
        id appStoreReceiptURL = [self valueForProxy:proxy selector:@selector(appStoreReceiptURL)];
        id storeFront = [self valueForProxy:proxy selector:@selector(storeFront)];
        id staticDiskUsage = [self valueForProxy:proxy selector:@selector(staticDiskUsage)];
        id deviceIdentifierForVendor = [self valueForProxy:proxy selector:@selector(deviceIdentifierForVendor)];
        id requiredDeviceCapabilities = [self valueForProxy:proxy selector:@selector(requiredDeviceCapabilities)];
        id appTags = [self valueForProxy:proxy selector:@selector(appTags)];
        id plugInKitPlugins = [self valueForProxy:proxy selector:@selector(plugInKitPlugins)];
        id VPNPlugins = [self valueForProxy:proxy selector:@selector(VPNPlugins)];
        id externalAccessoryProtocols = [self valueForProxy:proxy selector:@selector(externalAccessoryProtocols)];
        id audioComponents = [self valueForProxy:proxy selector:@selector(audioComponents)];
        id UIBackgroundModes = [self valueForProxy:proxy selector:@selector(UIBackgroundModes)];
        id directionsModes = [self valueForProxy:proxy selector:@selector(directionsModes)];
        id groupContainers = [self valueForProxy:proxy selector:@selector(groupContainers)];
        id vendorName = [self valueForProxy:proxy selector:@selector(vendorName)];
        id applicationType = [self valueForProxy:proxy selector:@selector(applicationType)];
        id sdkVersion = [self valueForProxy:proxy selector:@selector(sdkVersion)];
#pragma clang diagnostic pop
        
        _dictionary = @{
            @"applicationIdentifier": applicationIdentifier,
            @"bundleVersion": bundleVersion,
            @"teamID": teamID,
            @"groupIdentifiers": groupIdentifiers,
            @"originalInstallType": originalInstallType,
            @"installType": installType,
            @"iconStyleDomain": iconStyleDomain,
            @"localizedShortName": localizedShortName,
            @"localizedName": localizedName,
            @"privateDocumentTypeOwner": privateDocumentTypeOwner,
            @"privateDocumentIconNames": privateDocumentIconNames,
            @"resourcesDirectoryURL": resourcesDirectoryURL,
            @"installProgress": installProgress,
            @"appStoreReceiptURL": appStoreReceiptURL,
            @"storeFront": storeFront,
            @"staticDiskUsage": staticDiskUsage,
            @"deviceIdentifierForVendor": deviceIdentifierForVendor,
            @"requiredDeviceCapabilities": requiredDeviceCapabilities,
            @"appTags": appTags,
            @"plugInKitPlugins": plugInKitPlugins,
            @"VPNPlugins": VPNPlugins,
            @"externalAccessoryProtocols": externalAccessoryProtocols,
            @"audioComponents": audioComponents,
            @"UIBackgroundModes": UIBackgroundModes,
            @"directionsModes": directionsModes,
            @"groupContainers": groupContainers,
            @"vendorName": vendorName,
            @"applicationType": applicationType,
            @"sdkVersion": sdkVersion
        };
        
    }
    return self;
}

- (NSString *)applicationIdentifier
{
    return self.dictionary[@"applicationIdentifier"];
}

- (NSString *)localizedName
{
    return self.dictionary[@"localizedName"];
}

- (id)valueForProxy:(id)proxy selector:(SEL)sel
{
    if ([proxy respondsToSelector:sel]) {
        NSString *str = NSStringFromSelector(sel);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([str isEqualToString:@"originalInstallType"] || [str isEqualToString:@"installType"]) {
            unsigned int rst = (unsigned int)[proxy performSelector:sel];
            return @(rst);
        } else {
            return [proxy performSelector:sel] ?: @"";
        }
#pragma clang diagnostic pop
    } else {
        return @"";
    }
}

+ (NSArray *)allKeys
{
    return @[
        @"applicationIdentifier",
        @"bundleVersion",
        @"teamID",
        @"groupIdentifiers",
        @"originalInstallType",
        @"installType",
        @"iconStyleDomain",
        @"localizedShortName",
        @"localizedName",
        @"privateDocumentTypeOwner",
        @"privateDocumentIconNames",
        @"resourcesDirectoryURL",
        @"installProgress",
        @"appStoreReceiptURL",
        @"storeFront",
        @"staticDiskUsage",
        @"deviceIdentifierForVendor",
        @"requiredDeviceCapabilities",
        @"appTags",
        @"plugInKitPlugins",
        @"VPNPlugins",
        @"externalAccessoryProtocols",
        @"audioComponents",
        @"UIBackgroundModes",
        @"directionsModes",
        @"groupContainers",
        @"vendorName",
        @"applicationType",
        @"sdkVersion"
    ];
}

+ (NSArray *)displayKeys
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalAppInfoWhiteList"] ?: @[
        @"applicationIdentifier",
        @"bundleVersion",
        @"localizedName",
        @"vendorName",
        @"applicationType"
    ];
}

+ (void)saveDisplayKeys:(NSArray *)keys
{
    [[NSUserDefaults standardUserDefaults] setObject:keys forKey:@"LocalAppInfoWhiteList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
