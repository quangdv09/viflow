//
//  AboutViewController.h
//  ViFlow
//
//  Created by Tuyen on 2/15/19.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutViewController : NSViewController
@property (weak) IBOutlet NSTextField *VersionInfo;
@property (weak) IBOutlet NSButton *CheckNewVersionButton;
@property (weak) IBOutlet NSButton *CheckUpdateOnStatus;

@end

NS_ASSUME_NONNULL_END
