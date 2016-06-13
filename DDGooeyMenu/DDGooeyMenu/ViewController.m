//
//  ViewController.m
//  DDGooeyMenu
//
//  Created by 张德荣 on 16/6/13.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "ViewController.h"
#import "Menu.h"

@interface ViewController ()
@property (nonatomic, strong) Menu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menu = [[Menu alloc] initWithFrame:CGRectMake(self.view.center.x - 50, self.view.frame.size.height - 200, 100, 100)];
    [self.view addSubview:_menu];
}

@end
