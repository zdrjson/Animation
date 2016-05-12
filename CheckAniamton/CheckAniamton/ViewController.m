//
//  ViewController.m
//  CheckAniamton
//
//  Created by 张德荣 on 16/5/12.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "ViewController.h"
#import "DownloadButton.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet DownloadButton *downloadButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.downloadButton.progressBarWidth = 200;
    self.downloadButton.progressBarHeight = 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
