//
//  TabBarItem.m
//  TabBarItemAnimation
//
//  Created by 张德荣 on 16/5/8.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "TabBarItem.h"
#import "UIView+KGViewExtend.h"
@implementation TabBarItem
- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.imageView.backgroundColor = [UIColor redColor];
//    self.titleLabel.backgroundColor = [UIColor greenColor];
    //如果仅仅是调整按钮内部titleLabel的imageView的位置，那么在layoutSubviews中单独设置位置即可
    if (self.currentTitle) {
        NSLog(@"%@",self.currentTitle);
        self.titleLabel.centerX = self.imageView.centerX = self.width * 0.5;
        self.imageView.top = 5;
        self.titleLabel.top = CGRectGetMaxY(self.imageView.frame) + 5;
        
    }
//    else
//    {
//        self.imageView.center = self.center;
//    }
    
}


@end
