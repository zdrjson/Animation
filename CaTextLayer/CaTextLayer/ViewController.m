//
//  ViewController.m
//  CaTextLayer
//
//  Created by 张德荣 on 16/5/26.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "ViewController.h"
static CGFloat const kTextLayerFontSize = 29.0f;
static CGFloat const kTextLayerSelectedFontSize = 35.0f;
static CGFloat const kLayerWidth = 300.0f;
static CGFloat const kLayerHeight = 40.0f;
static CGFloat const kAnimationDuration = 5.0f;
@interface ViewController ()
@property (nonatomic, strong) CATextLayer *colorTextLayer;
@property (nonatomic, strong) CATextLayer *maskTextLayer;

@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *bottomLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)p_initLayers {
    self.colorTextLayer = [CATextLayer layer];
    self.colorTextLayer.string = @"我会整体变色哦";
    self.colorTextLayer.foregroundColor = [UIColor blackColor].CGColor;
    [self p_commonInitTextLayer:self.colorTextLayer];
    [self.view.layer addSublayer:self.colorTextLayer];
    
    self.topLayer = [CALayer layer];
    self.topLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.topLayer.frame = CGRectMake(0, 0, 0, kLayerHeight);
    
    self.bottomLayer = [CALayer layer];
    self.bottomLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.bottomLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerHeight);
    [self.bottomLayer addSublayer:self.topLayer];
    [self.view.layer addSublayer:self.bottomLayer];
    
    self.maskTextLayer = [CATextLayer layer];
    self.maskTextLayer.string = @"我会区域变色哦";
    self.maskTextLayer.foregroundColor = [UIColor whiteColor].CGColor;
    [self p_commonInitTextLayer:self.maskTextLayer];
    self.maskTextLayer.frame = self.bottomLayer.bounds;
    
    self.bottomLayer.mask = self.maskTextLayer;
    
}
- (void)p_addAniamtionForLayers{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
    colorAnimation.duration = kAnimationDuration;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fromValue = (id)[UIColor blackColor].CGColor;
    colorAnimation.toValue = (id)[UIColor redColor].CGColor;
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"fontSize"];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(kTextLayerFontSize);
    scaleAnimation.toValue = @(kTextLayerSelectedFontSize);
    scaleAnimation
    
}
- (void)p_commonInitTextLayer:(CATextLayer *)textLayer {
    textLayer.fontSize = kTextLayerFontSize;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = CGRectMake(0, 0, kLayerWidth, kLayerHeight);
}
@end
