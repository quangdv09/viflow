//
//  AppDelegate.m
//  ViFlowUpdate
//
//  Created by Do Vinh Quang on 5/15/26.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import "AppDelegate.h"

static NSString * const kMainBundleIdentifier = @"com.quangdv09.viflow";
static NSString * const kVersionURLString = @"https://raw.githubusercontent.com/quangdv09/viflow/main/version.json";
static NSString * const kReleaseDownloadURLFormat = @"https://github.com/quangdv09/viflow/releases/download/v%@/ViFlow%@-macOS.zip";
static NSString * const kFallbackReleaseDownloadURLFormat = @"https://github.com/quangdv09/viflow/releases/download/v%@/ViFlow%@.zip";

@interface AppDelegate ()
@property (nonatomic, assign) BOOL updateStarted;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if (self.updateStarted) {
        return;
    }
    self.updateStarted = YES;

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp activateIgnoringOtherApps:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSError *error = nil;
        BOOL updated = [self runUpdate:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (updated) {
                [self openInstalledViFlow];
            } else {
                [self showMessage:@"Có lỗi trong quá trình cập nhật"
                           detail:error.localizedDescription ?: @"Vui lòng tải ViFlow thủ công từ GitHub Releases."];
            }
            [NSApp terminate:nil];
        });
    });
}

- (BOOL)runUpdate:(NSError **)error {
    NSString *version = [self requestedVersion:error];
    if (version.length == 0) {
        return NO;
    }

    if (![self waitForMainAppToQuit:error]) {
        return NO;
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *workPath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"ViFlowUpdate-%@", [NSUUID UUID].UUIDString]];
    NSString *extractPath = [workPath stringByAppendingPathComponent:@"extracted"];
    NSString *zipPath = [workPath stringByAppendingPathComponent:
                         [NSString stringWithFormat:@"ViFlow%@-macOS.zip", version]];

    if (![fileManager createDirectoryAtPath:extractPath withIntermediateDirectories:YES attributes:nil error:error]) {
        return NO;
    }

    if (![self downloadVersion:version toPath:zipPath error:error]) {
        [fileManager removeItemAtPath:workPath error:nil];
        return NO;
    }

    if (![self runTask:@"/usr/bin/ditto" arguments:@[@"-x", @"-k", zipPath, extractPath] error:error]) {
        [fileManager removeItemAtPath:workPath error:nil];
        return NO;
    }

    NSString *newAppPath = [self findExtractedViFlowAppInPath:extractPath];
    if (newAppPath.length == 0) {
        if (error) {
            *error = [self errorWithDescription:@"Không tìm thấy ViFlow.app trong gói cập nhật."];
        }
        [fileManager removeItemAtPath:workPath error:nil];
        return NO;
    }

    NSString *targetPath = [self targetAppPath];
    NSString *targetParentPath = [targetPath stringByDeletingLastPathComponent];
    if (![fileManager createDirectoryAtPath:targetParentPath withIntermediateDirectories:YES attributes:nil error:error]) {
        [fileManager removeItemAtPath:workPath error:nil];
        return NO;
    }

    if ([fileManager fileExistsAtPath:targetPath]) {
        if (![fileManager removeItemAtPath:targetPath error:error]) {
            [fileManager removeItemAtPath:workPath error:nil];
            return NO;
        }
    }

    if (![fileManager copyItemAtPath:newAppPath toPath:targetPath error:error]) {
        [fileManager removeItemAtPath:workPath error:nil];
        return NO;
    }

    [fileManager removeItemAtPath:workPath error:nil];
    return YES;
}

- (NSString *)requestedVersion:(NSError **)error {
    NSString *argumentVersion = [self valueForArgumentPrefix:@"--version="];
    if (argumentVersion.length > 0) {
        return argumentVersion;
    }

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kVersionURLString]
                                         options:NSDataReadingUncached
                                           error:error];
    if (data.length == 0) {
        return nil;
    }

    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (![object isKindOfClass:[NSDictionary class]]) {
        if (error) {
            *error = [self errorWithDescription:@"Không đọc được thông tin phiên bản mới."];
        }
        return nil;
    }

    NSDictionary *versionInfo = [(NSDictionary *)object valueForKey:@"latestVersion"];
    NSString *versionName = [versionInfo valueForKey:@"versionName"];
    if (versionName.length == 0 && error) {
        *error = [self errorWithDescription:@"Không tìm thấy versionName trong version.json."];
    }
    return versionName;
}

- (BOOL)downloadVersion:(NSString *)version toPath:(NSString *)path error:(NSError **)error {
    NSArray<NSString *> *urlStrings = @[
        [NSString stringWithFormat:kReleaseDownloadURLFormat, version, version],
        [NSString stringWithFormat:kFallbackReleaseDownloadURLFormat, version, version],
    ];

    for (NSString *urlString in urlStrings) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]
                                             options:NSDataReadingUncached
                                               error:nil];
        if (data.length > 0 && [data writeToFile:path options:NSDataWritingAtomic error:error]) {
            return YES;
        }
    }

    if (error) {
        *error = [self errorWithDescription:
                  [NSString stringWithFormat:@"Không tải được gói cập nhật ViFlow %@.", version]];
    }
    return NO;
}

- (BOOL)waitForMainAppToQuit:(NSError **)error {
    for (NSRunningApplication *app in [NSWorkspace sharedWorkspace].runningApplications) {
        if ([app.bundleIdentifier isEqualToString:kMainBundleIdentifier]) {
            [app terminate];
        }
    }

    for (int i = 0; i < 50; i++) {
        BOOL stillRunning = NO;
        for (NSRunningApplication *app in [NSWorkspace sharedWorkspace].runningApplications) {
            if ([app.bundleIdentifier isEqualToString:kMainBundleIdentifier]) {
                stillRunning = YES;
                break;
            }
        }
        if (!stillRunning) {
            return YES;
        }
        [NSThread sleepForTimeInterval:0.2];
    }

    for (NSRunningApplication *app in [NSWorkspace sharedWorkspace].runningApplications) {
        if ([app.bundleIdentifier isEqualToString:kMainBundleIdentifier]) {
            [app forceTerminate];
        }
    }

    [NSThread sleepForTimeInterval:0.5];
    for (NSRunningApplication *app in [NSWorkspace sharedWorkspace].runningApplications) {
        if ([app.bundleIdentifier isEqualToString:kMainBundleIdentifier]) {
            if (error) {
                *error = [self errorWithDescription:@"Không thể tắt ViFlow để cập nhật."];
            }
            return NO;
        }
    }
    return YES;
}

- (NSString *)findExtractedViFlowAppInPath:(NSString *)path {
    NSString *defaultPath = [path stringByAppendingPathComponent:@"ViFlow.app"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultPath]) {
        return defaultPath;
    }

    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    NSString *item = nil;
    while ((item = [enumerator nextObject])) {
        if ([item.lastPathComponent isEqualToString:@"ViFlow.app"]) {
            return [path stringByAppendingPathComponent:item];
        }
    }
    return nil;
}

- (NSString *)targetAppPath {
    NSString *argumentPath = [self valueForArgumentPrefix:@"--app-path="];
    if (argumentPath.length > 0) {
        return argumentPath;
    }
    return @"/Applications/ViFlow.app";
}

- (NSString *)valueForArgumentPrefix:(NSString *)prefix {
    for (NSString *argument in [NSProcessInfo processInfo].arguments) {
        if ([argument hasPrefix:prefix]) {
            return [argument substringFromIndex:prefix.length];
        }
    }
    return nil;
}

- (BOOL)runTask:(NSString *)launchPath arguments:(NSArray<NSString *> *)arguments error:(NSError **)error {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = launchPath;
    task.arguments = arguments;

    if (![task launchAndReturnError:error]) {
        return NO;
    }

    [task waitUntilExit];
    if (task.terminationStatus != 0) {
        if (error) {
            *error = [self errorWithDescription:
                      [NSString stringWithFormat:@"%@ chạy lỗi với mã %d.",
                       launchPath.lastPathComponent,
                       task.terminationStatus]];
        }
        return NO;
    }
    return YES;
}

- (void)openInstalledViFlow {
    NSURL *appURL = [NSURL fileURLWithPath:[self targetAppPath]];
    NSWorkspaceOpenConfiguration *config = [NSWorkspaceOpenConfiguration configuration];
    [[NSWorkspace sharedWorkspace] openApplicationAtURL:appURL configuration:config completionHandler:nil];
}

- (void)showMessage:(NSString *)message detail:(NSString *)detail {
    [NSApp activateIgnoringOtherApps:YES];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = message;
    alert.informativeText = detail ?: @"";
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}

- (NSError *)errorWithDescription:(NSString *)description {
    return [NSError errorWithDomain:@"ViFlowUpdate"
                               code:1
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
