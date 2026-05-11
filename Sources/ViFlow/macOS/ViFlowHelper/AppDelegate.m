//
//  AppDelegate.m
//  OpenKeyHelper
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
    if (![runningApp containsObject:@"com.quangdv09.viflow"]) {
        NSString* path = [[NSBundle mainBundle] bundlePath];
        for (int i = 0; i < 4; i++)
            path = [path stringByDeletingLastPathComponent];
        [[NSWorkspace sharedWorkspace] launchApplication:path];
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
