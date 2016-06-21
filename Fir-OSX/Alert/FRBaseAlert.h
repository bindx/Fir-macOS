//
//  FRBaseAlert.h
//  Fir-OSX
//
//  Created by gejw on 16/6/21.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRWindow : NSWindow

@end

@interface FRBaseAlert : NSObject

@property (nonatomic, strong) FRWindow *window;

- (void)showFromWindow:(NSWindow *)window;

- (void)show;

- (void)dismiss;

@end
