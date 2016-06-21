//
//  FRUserListCell.h
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FRUser.h"

@interface FRUserListCell : NSTableCellView

@property (nonatomic, strong) FRUser *user;

@property (weak) IBOutlet NSTextField *nameLabel;

@end
