//
//  FirstVc.m
//  TabBarItemAnimation
//
//  Created by 张德荣 on 16/5/8.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "FirstVc.h"
#import "ViewController.h"

@interface FirstVc ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation FirstVc
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 100, 30)];
        _label.center = self.view.center;
        _label.backgroundColor = [UIColor redColor];
        _label.text = @"xxxx";
        _label.textColor = [UIColor grayColor];
    }
    return _label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.label];

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
    return;
    CABasicAnimation *currentLabelBasicAnimaton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    currentLabelBasicAnimaton.duration = 1.0f;
    currentLabelBasicAnimaton.fromValue = @1;
    currentLabelBasicAnimaton.toValue =@1.5;
        currentLabelBasicAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  currentLabelBasicAnimaton.beginTime = CACurrentMediaTime();
    currentLabelBasicAnimaton.removedOnCompletion = NO;
    currentLabelBasicAnimaton.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:currentLabelBasicAnimaton forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
