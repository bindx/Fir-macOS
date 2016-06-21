//
//  FRAppQRCodeAlert.h
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRBaseAlert.h"

@interface FRAppQRCodeAlert : FRBaseAlert

@property (weak) IBOutlet NSButton *imageView;

@property (weak) IBOutlet NSTextField *descLabel;

@end
