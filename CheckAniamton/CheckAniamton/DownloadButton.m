//
//  DownloadButton.m
//  CheckAniamton
//
//  Created by 张德荣 on 16/5/12.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "DownloadButton.h"

@implementation DownloadButton
{
    BOOL animating;
    CGRect originframe;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSomething];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSomething];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSomething];
    }
    return self;
}
- (void)setupSomething {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGes];
}
#pragma mark -- UITapGesture
- (void)tapped:(UITapGestureRecognizer *)tapGes {
    originframe = self.frame;
    if (animating == YES) {
        return;
    }
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    
    animating = YES;
    
    self.layer.cornerRadius = self.progressBarHeight / 2;
    
    CABasicAnimation *raduisShrinkAnimaton = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    raduisShrinkAnimaton.duration = 0.2f;
    raduisShrinkAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    raduisShrinkAnimaton.fromValue = @(originframe.size.height / 2);
    
    //not to set toValue
    raduisShrinkAnimaton.delegate = self;
    [self.layer addAnimation:raduisShrinkAnimaton forKey:@"cornerRadiusShrinkAnim"];
}
- (void)animationDidStart:(CAAnimation *)anim {
    if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusShrinkAnim"]]) {
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, _progressBarWidth, _progressBarHeight);
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self progressBarAnimaton];
        }];
    } else if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusExpandAnim"]]){
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, originframe.size.width, originframe.size.height);
            self.backgroundColor = [UIColor colorWithRed:0.1803921568627451 green:0.8 blue:0.44313725490196076 alpha:1.0];
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self checkAnimation];
            animating = NO;
        }];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"progressBarAnimation"]) {
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer *subLayer in self.layer.sublayers) {
                subLayer.opacity = 0.0f;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                for (CALayer *subLayer in self.layer.sublayers) {
                    [subLayer removeFromSuperlayer];
                }
                
                self.layer.cornerRadius = originframe.size.height / 2;
                CABasicAnimation *radiusExpandAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                radiusExpandAnimation.duration = 0.2f;
                radiusExpandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                radiusExpandAnimation.fromValue = @(_progressBarHeight / 2);
                radiusExpandAnimation.delegate = self;
                [self.layer addAnimation:radiusExpandAnimation forKey:@"cornerRadiusExpandAnim"];
            }
        }];
    }
}

#pragma mark -- Helper
- (void)progressBarAnimaton {
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_progressBarHeight/ 2, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - _progressBarHeight/2, self.bounds.size.height/2)];
    progressLayer.path = path.CGPath;
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.lineWidth = _progressBarHeight-6;
    progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:progressLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0f;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    pathAnimation.delegate = self;
    [pathAnimation setValue:@"progressBarAnimation" forKey:@"animationName"];
    [progressLayer addAnimation:pathAnimation forKey:nil];
}

- (void)checkAnimation {
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3, rectInCircle.origin.y + rectInCircle.size.height * 9/10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width *8/10, rectInCircle.origin.y + rectInCircle.size.height *2/10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.lineWidth = 10.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];
    
    
    CABasicAnimation *checkAnimaton = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimaton.duration = 0.3f;
    checkAnimaton.fromValue = @(0.0f);
    checkAnimaton.toValue = @(1.0f);
    checkAnimaton.delegate = self;
    [checkAnimaton setValue:@"checkAniamton" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimaton forKey:nil];
    
}
@end
