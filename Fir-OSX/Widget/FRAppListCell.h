//
//  FRAppListCell.h
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FRAppListCell : NSTableCellView

@property (nonatomic, strong) FRApp* app;
@property (weak) IBOutlet PVAsyncImageView *iconImageView;
@property (weak) IBOutlet NSTextField *appNameLabel;
@property (weak) IBOutlet NSTextField *appVersionLabel;
@property (weak) IBOutlet NSTextField *uploadTimeLabel;
@property (weak) IBOutlet NSButton *linkButton;

@end
