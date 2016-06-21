//
//  AppDelegate.m
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "AppDelegate.h"
#import "FRMainWindow.h"

@interface AppDelegate ()

@property (weak) IBOutlet FRMainWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_window setup];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
