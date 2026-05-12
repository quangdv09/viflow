//
//  MyTextField.h
//  ViFlow
//
//  Created by Tuyen on 7/30/19.
//  Copyright © 2026 Do Vinh Quang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol MyTextFieldDelegate
@optional
-(void)onMyTextFieldKeyChange:(unsigned short)keyCode character:(unsigned short)character;
@end

@interface MyTextField : NSTextField<NSTextDelegate>
@property (weak, nonatomic) id<MyTextFieldDelegate> Parent;
@property unsigned short LastKeyCode;
@property unsigned short LastKeyChar;

-(void)setTextByChar:(unsigned short)chr;
@end
