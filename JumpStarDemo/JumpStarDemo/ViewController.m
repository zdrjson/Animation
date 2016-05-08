//
//  ViewController.m
//  JumpStarDemo
//
//  Created by 张德荣 on 16/5/5.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ViewController.h"
#import "JumpStarView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet JumpStarView *jumpStarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_jumpStarView layoutIfNeeded];
    _jumpStarView.markedImage = [UIImage imageNamed:@"icon_star_incell"];
    _jumpStarView.non_markedImage = [UIImage imageNamed:@"blue_dot"];
    _jumpStarView.state = NONMARK;
}
- (IBAction)tapped:(id)sender {
    [_jumpStarView animate];
}
@end
