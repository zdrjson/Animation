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
    if (self.starView == nil) {
        self.starView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2- (self.bounds.size.width-6)/2, 0, self.bounds.size.width - 6, self.bounds.size.height -6)];
        self.starView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.starView];
    }
    if (self.shadowView == nil) {
        self.shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3)];
        self.shadowView.alpha = 0.4;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];
    }
}
-(void)setState:(STATE)state {
    _state = state;
    self.starView.image = _state==Mark? _markedImage:_non_markedImage;
 
}

- (void)animate {
    if (_animating == YES) {
        return;
    }
    
    _animating = YES;
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnimation.fromValue = @0;
    transformAnimation.toValue = @(M_PI_2);
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.fromValue = @(self.starView.center.y);
    positionAnimation.toValue = @(self.starView.center.y - 14);
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = jumpDuration;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = NO;
    animGroup.delegate = self;
    animGroup.animations = @[transformAnimation,positionAnimation];
    
    [self.starView.layer addAnimation:animGroup forKey:@"jumpUp"];
}
-(void)animationDidStart:(CAAnimation *)anim {
    if ([anim isEqual:[self.starView.layer animationForKey:@"jumpUp"]]) {
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha = 0.2;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width * 1.6, _shadowView.bounds.size.height);
        } completion:nil];
    }else if ([anim isEqual:[self.starView.layer animationForKey:@"jumpDown"]]) {
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha = 0.4;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width / 1.6, _shadowView.bounds.size.height);
        } completion:nil];
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isEqual:[self.starView.layer animationForKey:@"jumpUp"]]) {
        self.state = self.state ==Mark?NONMARK:Mark;
        CABasicAnimation *tranformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        tranformAnimation.fromValue = @(M_PI_2);
        tranformAnimation.toValue = @(M_PI);
        tranformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *postionAnimaton = [CABasicAnimation animationWithKeyPath:@"position.y"];
        postionAnimaton.fromValue = @(self.starView.center.y - 14);
        postionAnimaton.toValue = @(self.starView.center.y);
        postionAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CAAnimationGroup *aninGroup = [CAAnimationGroup animation];
        aninGroup.duration = downDuration;
        aninGroup.fillMode  = kCAFillModeForwards;
        aninGroup.removedOnCompletion = NO;
        aninGroup.delegate = self;
        aninGroup.animations = @[tranformAnimation,postionAnimaton];
        
        [self.starView.layer addAnimation:aninGroup forKey:@"jumpDown"];
    } else if ([anim isEqual:[self.starView.layer animationForKey:@"jumpDown"]]) {
        [self.starView.layer removeAllAnimations];
        _animating = NO;
    }
}
@end
