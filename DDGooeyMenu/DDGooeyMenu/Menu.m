//
//  Menu.m
//  DDGooeyMenu
//
//  Created by 张德荣 on 16/6/13.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "Menu.h"

@implementation Menu
- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect real_frame = CGRectInset(frame, -30, -30);
    self = [super initWithFrame:real_frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end
