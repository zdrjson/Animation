//
//  ViewController.m
//  CAGroupAninaiton
//
//  Created by 张德荣 on 16/5/5.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *sequencePositonArray;
@property (nonatomic, strong) NSMutableArray *sequenceViewArray;
@property (nonatomic, strong) NSArray *colorArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat centerX = self.view.center.x;
    CGFloat centerY = self.view.center.y;
    
    CGFloat delta = 2 * M_PI/8;
    
    CGFloat x = centerX + 50 * cos(delta * 7);
    CGFloat y = centerY + 50 * sin(delta * 7);
    
    [self.sequencePositonArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    view1.center = self.view.center;
    view1.backgroundColor = self.colorArray[0];
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;
    view1.layer.transform = CATransform3DMakeScale(0, 0, 0);
    [self.view addSubview:view1];
    
    [self.sequenceViewArray addObject:view1];
    
    
    for (int i = 0; i<7; i++) {
        CGFloat x = centerX + 50 * cos(delta*i);
        CGFloat y = centerY + 50 * sin(delta*i);
        
        [self.sequencePositonArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.center = self.view.center;
        view.backgroundColor = self.colorArray[i+1];
        view.layer.cornerRadius = 5;
        view.layer.transform = CATransform3DMakeScale(0, 0, 0);
        view.layer.masksToBounds = YES;
        [self.view addSubview:view];
        
        [self.sequenceViewArray addObject:view];
        
    }
    
}

- (CAAnimationGroup *)createGroupAnimationWithDelay:(CFTimeInterval)time withIndex:(NSInteger)index {
    CABasicAnimation *moveAnimaton = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimaton.fromValue = [NSValue valueWithCGPoint:self.view.center];
    moveAnimaton.toValue = self.sequencePositonArray[index];
    moveAnimaton.duration = 0.75;
    moveAnimaton.autoreverses = YES;
    
    CABasicAnimation *scaleAnimaton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimaton.fromValue = @0;
    scaleAnimaton.toValue = @1;
    scaleAnimaton.duration = 0.75;
    scaleAnimaton.autoreverses = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveAnimaton,scaleAnimaton];
    group.autoreverses = YES;
    group.duration = 0.75;
    group.repeatCount = HUGE_VALF;
    group.beginTime = CACurrentMediaTime() + time;
    return group;
    

}
- (IBAction)startAnimation:(id)sender
{
    for (int i = 0; i<self.sequenceViewArray.count; i++) {
        UIView *view = self.sequenceViewArray[i];
        [view.layer addAnimation:[self createGroupAnimationWithDelay:i * 0.1 withIndex:i] forKey:@"group"];
    }
}
- (NSArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = @[[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor blueColor],[UIColor blackColor],[UIColor grayColor],[UIColor orangeColor]];
    }
    return _colorArray;
}
- (NSMutableArray *)sequencePositonArray
{
    if (!_sequencePositonArray) {
        _sequencePositonArray = [[NSMutableArray alloc] init];
    }
    return _sequencePositonArray;
}
- (NSMutableArray *)sequenceViewArray
{
    if (!_sequenceViewArray) {
        _sequenceViewArray = [[NSMutableArray alloc] init];
    }
    return _sequenceViewArray;
}
@end
