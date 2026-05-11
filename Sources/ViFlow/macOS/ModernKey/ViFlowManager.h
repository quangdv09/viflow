//
//  ViFlowManager.h
//  ModernKey
//
//  Created by Tuyen on 1/27/19.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#ifndef ViFlowManager_h
#define ViFlowManager_h

#import <Cocoa/Cocoa.h>

typedef void (^CheckNewVersionCallback)(void);

@interface ViFlowManager : NSObject
+(BOOL)isInited;
+(BOOL)initEventTap;
+(BOOL)stopEventTap;

+(NSArray*)getTableCodes;

+(NSString*)getBuildDate;
+(void)showMessage:(NSWindow*)window message:(NSString*)msg subMsg:(NSString*)subMsg;

+(BOOL)quickConvert;

+(void)checkNewVersion:(NSWindow*)parent callbackFunc:(CheckNewVersionCallback) callback;
+(BOOL)isUpdateCheckEnabled;
@end

#endif /* ViFlowManager_h */
