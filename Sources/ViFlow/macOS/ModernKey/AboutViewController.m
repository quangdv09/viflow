//
//  AboutViewController.m
//  ViFlow
//
//  Created by Tuyen on 2/15/19.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import "AboutViewController.h"
#import "ViFlowManager.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.VersionInfo.stringValue = [NSString stringWithFormat:@"Phiên bản %@ (build %@) - Ngày cập nhật %@",
                                    [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"],
                                    [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleVersion"],
                                    [ViFlowManager getBuildDate]] ;
    
    NSInteger dontCheckUpdate = [[NSUserDefaults standardUserDefaults] integerForKey:@"DontCheckUpdate"];
    self.CheckUpdateOnStatus.state = dontCheckUpdate ? NSControlStateValueOff :NSControlStateValueOn;

    if (![ViFlowManager isUpdateCheckEnabled]) {
        self.CheckUpdateOnStatus.state = NSControlStateValueOff;
        self.CheckUpdateOnStatus.enabled = NO;
        self.CheckNewVersionButton.enabled = NO;
        self.CheckNewVersionButton.title = @"Tạm thời tắt";
    }
}

- (IBAction)onHomePage:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://github.com/quangdv09/viflow"]];
}

- (IBAction)onFanPage:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://github.com/quangdv09/viflow"]];
}

- (IBAction)onLatestReleaseVersion:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://github.com/quangdv09/viflow/releases"]];
}

- (IBAction)onCheckUpdateOnStartup:(NSButton *)sender {
    if (![ViFlowManager isUpdateCheckEnabled]) {
        sender.state = NSControlStateValueOff;
        return;
    }
    NSInteger val = sender.state == NSControlStateValueOn ? 0 : 1;
    [[NSUserDefaults standardUserDefaults] setInteger:val forKey:@"DontCheckUpdate"];
}

- (IBAction)onCheckNewVersion:(id)sender {
    if (![ViFlowManager isUpdateCheckEnabled]) {
        [ViFlowManager checkNewVersion:self.view.window callbackFunc:^{
        }];
        return;
    }
    
    self.CheckNewVersionButton.title = @"Đang kiểm tra...";
    self.CheckNewVersionButton.enabled = false;
    
    [ViFlowManager checkNewVersion: self.view.window callbackFunc:^{
        self.CheckNewVersionButton.enabled = true;
        self.CheckNewVersionButton.title = @"Kiểm tra bản mới...";
    }];
}

@end
