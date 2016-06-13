//
//  Menu.m
//  DDGooeyMenu
//
//  Created by 张德荣 on 16/6/13.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "Menu.h"

@interface Menu ()
@property (nonatomic, strong) NSMutableArray *animationQueue;

@end

@implementation Menu
- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect real_frame = CGRectInset(frame, -30, -30);
    self = [super initWithFrame:real_frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        _animationQueue = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    _menuLayer = [MenuLayer layer];
    _menuLayer.frame = self.bounds;
    _menuLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_menuLayer];
    [_menuLayer setNeedsDisplay];
}
@end
