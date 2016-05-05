//
//  JumpStarView.m
//  JumpStarDemo
//
//  Created by 张德荣 on 16/5/6.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "JumpStarView.h"

#define jumpDuration 0.125
#define downDuration 0.215

@interface JumpStarView ()

@property (nonatomic, strong) UIImageView *starView;

@property (nonatomic, strong) UIImageView *shadowView;
@property (nonatomic, assign) BOOL animating;

@end

@implementation JumpStarView
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
