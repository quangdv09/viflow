//
//  main.m
//  ViFlowUpdate
//
//  Created by Do Vinh Quang on 5/15/26.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        application.delegate = delegate;
        [application run];
    }
    return 0;
}
