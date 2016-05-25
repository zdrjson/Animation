//
//  ViewController.m
//  TinderRippleAnimation
//
//  Created by 张德荣 on 16/5/25.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRippleAnimation];
}

- (void)setupRippleAnimation {
    
    
    CGFloat width = 4;
    CGRect pathFrame = CGRectMake(0, 0, 4, 4);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = path.bounds;
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:1.00f green:0.71f blue:0.71f alpha:1.00f] CGColor];
    shapeLayer.fillColor = [UIColor colorWithRed:1.00f green:0.82f blue:0.82f alpha:1.00f].CGColor;
    shapeLayer.lineWidth = 0.05;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(60, 60, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,alphaAnimation];
    animation.duration = 2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [shapeLayer addAnimation:animation forKey:nil];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    //    UIView *imageView = [UIView new];
    //    imageView.image.size = CGSizeMake(20, 20);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    CGFloat imageViewWidth = 80;
    imageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewWidth);
    imageView.center = self.view.center;
    //    imageView.layer.borderWidth = 15;
    imageView.layer.cornerRadius = imageViewWidth/2;
    //    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    //    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    imageView.tintColor = [UIColor whiteColor];
    //    imageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:imageView];
    //    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@",NSStringFromCGRect(shapeLayer.frame));
}

@end
