//
//  FRDragView.m
//  Fir-OSX
//
//  Created by gejw on 16/6/17.
//  Copyright © 2016年 slightech. All rights reserved.
//

#import "FRDragView.h"

@implementation FRDragView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commitIn];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commitIn];
    }
    return self;
}

- (void)setFileTypes:(NSArray<NSString *> *)fileTypes {
    NSMutableArray *types = [NSMutableArray array];
    for (NSString *type in fileTypes) {
        [types addObject:[type lowercaseString]];
    }
    _fileTypes = types;
}

- (void)commitIn {
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSArray *list = [pasteboard propertyListForType:NSFilenamesPboardType];
    if (list.count == 1 && _fileTypes != nil) {
        NSString *path = [list objectAtIndex:0];
        if ([_fileTypes containsObject:[[path pathExtension] lowercaseString]]) {
            return NSDragOperationCopy;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(dragView:didDragFileError:)]) {
        [_delegate dragView:self didDragFileError:[NSError errorWithDomain:@"file is not support" code:-1 userInfo:@{}]];
    }
    // 判断文件类型
    return NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSArray *list = [pasteboard propertyListForType:NSFilenamesPboardType];
    if (list.count == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(dragView:didDragFilePath:)]) {
            [_delegate dragView:self didDragFilePath:[list objectAtIndex:0]];
        }
    }
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}

@end
