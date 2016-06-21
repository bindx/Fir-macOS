//
//  FRDragView.h
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FRDragView;

@protocol FRDragViewDelegate <NSObject>

- (void)dragView:(FRDragView *)view didDragFilePath:(NSString *)path;

- (void)dragView:(FRDragView *)view didDragFileError:(NSError *)error;

@end

@interface FRDragView : NSView

@property (nonatomic, weak) id<FRDragViewDelegate> delegate;

/**
 *  支持拖拽的文件后缀(大小写随意)
 */
@property (nonatomic, strong) NSArray <NSString *> *fileTypes;

@end
