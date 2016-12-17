//
//  ABSItunesAppInfo.m
//  AppBrowser
//
//  Created by little2s on 2016/12/16.
//  Copyright © 2016年 little2s. All rights reserved.
//

#import "ABSItunesAppInfo.h"

@implementation ABSItunesAppInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = dictionary;
    }
    return self;
}

- (NSString *)bundleId
{
    return self.dictionary[@"bundleId"] ?: @"";
}

- (NSString *)trackName
{
    return self.dictionary[@"trackName"] ?: @"";
}

- (NSString *)trackId
{
    return self.dictionary[@"trackId"] ? [self.dictionary[@"trackId"] stringValue] : @"";
}

+ (NSArray *)allKeys
{
    return @[
        @"isGameCenterEnabled",
        @"artistViewUrl",
        @"artworkUrl60",
        @"artworkUrl100",
        @"ipadScreenshotUrls",
        @"kind",
        @"features",
        @"supportedDevices",
        @"advisories",
        @"screenshotUrls",
        @"trackCensoredName",
        @"trackViewUrl",
        @"fileSizeBytes",
        @"sellerUrl",
        @"currency",
        @"contentAdvisoryRating",
        @"languageCodesISO2A",
        @"wrapperType",
        @"version",
        @"description",
        @"artistId",
        @"artistName",
        @"genres",
        @"price",
        @"bundleId",
        @"trackId",
        @"trackName",
        @"releaseDate",
        @"primaryGenreName",
        @"isVppDeviceBasedLicensingEnabled",
        @"releaseNotes",
        @"currentVersionReleaseDate",
        @"sellerName",
        @"primaryGenreId",
        @"formattedPrice",
        @"minimumOsVersion",
        @"genreIds"
    ];
}

+ (NSArray *)displayKeys
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ItunesResultWhiteList"] ?: @[
        @"bundleId",
        @"trackName",
        @"artistName",
        @"releaseDate",
        @"currentVersionReleaseDate",
        @"minimumOsVersion",
        @"sellerName",
        @"version",
        @"wrapperType",
        @"trackViewUrl"
    ];
}

+ (void)saveDisplayKeys:(NSArray *)keys
{
    [[NSUserDefaults standardUserDefaults] setObject:keys forKey:@"ItunesResultWhiteList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
