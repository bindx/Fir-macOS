//
//  FRBaseAlert.m
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRBaseAlert.h"

@implementation FRWindow

- (BOOL)canBecomeKeyWindow {
    return true;
}

@end

@implementation FRBaseAlert

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self topLevelObjects:nil];
    }
    return self;
}

- (void)showFromWindow:(NSWindow *)window {
    [window beginSheet:_window completionHandler:nil];
    [NSApp runModalForWindow:_window];
}

- (void)show {
    NSWindow *window = [[NSApp windows] firstObject];
    [window beginSheet:_window completionHandler:nil];
    [NSApp runModalForWindow:_window];
}

- (void)dismiss {
    [NSApp stopModal];
    [_window.parentWindow endSheet:_window];
    [_window close];
}


@end
