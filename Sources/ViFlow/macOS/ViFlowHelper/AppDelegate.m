//
//  AppDelegate.m
//  ViFlowHelper
//
//  Created by Tuyen on 2/1/19.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSArray* runningApp = [[NSWorkspace sharedWorkspace] runningApplications];
    BOOL mainAppIsRunning = NO;
    for (NSRunningApplication *app in runningApp) {
        if ([app.bundleIdentifier isEqualToString:@"com.quangdv09.viflow"]) {
            mainAppIsRunning = YES;
            break;
        }
    }

    if (!mainAppIsRunning) {
        NSString* path = [[NSBundle mainBundle] bundlePath];
        for (int i = 0; i < 4; i++)
            path = [path stringByDeletingLastPathComponent];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSWorkspaceOpenConfiguration *config = [NSWorkspaceOpenConfiguration configuration];
        [[NSWorkspace sharedWorkspace] openApplicationAtURL:url configuration:config completionHandler:nil];
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
