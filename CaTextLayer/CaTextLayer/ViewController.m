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
    
}
- (void)p_commonInitTextLayer:(CATextLayer *)textLayer {
//    textLayer.fontSize =
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = CGRectMake(0, 0, kLayerWidth, kLayerHeight);
}
@end
