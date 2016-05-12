//
//  TabBarVc.m
//  TabBarItemAnimation
//
//  Created by 张德荣 on 16/5/8.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "TabBarVc.h"
#import "FirstVc.h"
#import "SecondVc.h"
#import "ThirdVc.h"
#import "FourthVc.h"
#import "FifthVc.h"
#import "NavVc.h"
#import "TabBarItem.h"
@interface TabBarVc() <UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, assign) TabBarItem *lastSelectedBtn;
@property (nonatomic, strong) NSArray *selectedImages;//选择的按钮图片
@property (nonatomic, strong) NSArray *unselectedImages;//未选择的按钮图片
@property (nonatomic, strong) NSArray *titles;//未选择的标题
/** tabBarItemTitle 与 VcName 数组 key --> title ，value --> VcClassName）*/
@property (nonatomic,strong) NSArray *titleVcNameArray;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *lastImageView;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) UIImageView *customTabBar;
@end

@implementation TabBarVc
#pragma mark lazy
- (NSArray *)titleVcNameArray
{
    if (!_titleVcNameArray) {
        self.titleVcNameArray = @[@{@"热门":[FirstVc new]},
                                  @{@"U秀":[SecondVc new]},
                                  @{@"U代":[ThirdVc new]},
                                  @{@"收藏":[FourthVc new]},
                                  @{@"我":[FifthVc new]}];
    }
    return _titleVcNameArray;
}
- (NSArray *)unselectedImages
{
    if (!_unselectedImages) {
        self.unselectedImages = @[@"ico_hot",
                                  @"ushow_home_icon",
                                  @"ico_ud",
                                  @"ico_sc",
                                  @"ico_profiles"];
    }
    return _unselectedImages;
}
- (NSArray *)selectedImages
{
    if (!_selectedImages) {
        self.selectedImages = @[@"ico_hot_selected",
                                @"tab_show_selected",
                                @"ico_ud_pre",
                                @"ico_sc_pre",
                                @"ico_profiles_selected"];
        
    }
    return _selectedImages;
}

- (NSArray *)titles
{
    if (!_titles) {
        self.titles = @[@"热门",@"U秀",@"U代",@"收藏",@"我"];
    }
    return _titles;
}
#pragma mark - UITabBarControllerDelegate

/**
 重写方法 防止bug
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self setTabBarItemSwitchAnimation];
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (!self.isFirst) {
        self.isFirst = YES;
        tabBarController.childViewControllers.firstObject.tabBarItem.imageInsets = UIEdgeInsetsZero;
    }

    [self setTabBarItemSwitchAnimation];
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag  {
    if ([anim isEqual:[self.currentImageView.layer animationForKey:@"CurrentImageViewPositionAniamationKey"]]) {
        CABasicAnimation *currentLabelBasicAnimaton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        currentLabelBasicAnimaton.duration = 0.3f;
        currentLabelBasicAnimaton.fromValue = @1.0;
        currentLabelBasicAnimaton.toValue =@1.5;
        //    currentLabelBasicAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        currentLabelBasicAnimaton.beginTime = CACurrentMediaTime();
        currentLabelBasicAnimaton.removedOnCompletion = NO;
        currentLabelBasicAnimaton.fillMode = kCAFillModeForwards;
        [self.currentImageView.layer addAnimation:currentLabelBasicAnimaton forKey:nil];
    }
    else if ([anim isEqual:[self.lastImageView.layer animationForKey:@"lastImageViewPositionAniamationKey"]])
    {
        CABasicAnimation *currentLabelBasicAnimaton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        currentLabelBasicAnimaton.duration = 0.3f;
        currentLabelBasicAnimaton.fromValue = @1.5;
        currentLabelBasicAnimaton.toValue =@1;
        //    currentLabelBasicAnimaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        currentLabelBasicAnimaton.beginTime = CACurrentMediaTime();
        currentLabelBasicAnimaton.removedOnCompletion = NO;
        currentLabelBasicAnimaton.fillMode = kCAFillModeForwards;
        [self.lastImageView.layer addAnimation:currentLabelBasicAnimaton forKey:nil];

    }
    
  


}
+ (void)injected {
    NSLog(@"xx");
}
#pragma mark - private method
- (void)setTabBarItemSwitchAnimation {
    if (self.selectedIndex == self.lastSelected) {
        return ;
    }
    
    //当前选中的BarItem
     TabBarItem *currentBtn = self.customTabBar.subviews[self.selectedIndex];
   
    
    UIImageView *currentImageView = currentBtn.subviews[0];
    UILabel *currentLabel = currentBtn.subviews[1];
    
    self.currentImageView = currentImageView;


    
    
    CABasicAnimation *currentLabelBasicAnimaton = [CABasicAnimation animationWithKeyPath:@"hidden"];
    currentLabelBasicAnimaton.removedOnCompletion = NO;
    currentLabelBasicAnimaton.fillMode = kCAFillModeForwards;
    currentLabelBasicAnimaton.fromValue = @NO;
    currentLabelBasicAnimaton.toValue = @YES;
    currentLabelBasicAnimaton.duration = 0.3;
    [currentLabel.layer addAnimation:currentLabelBasicAnimaton forKey:nil];
    
    
    
    
    CABasicAnimation *keyframeAniamton = [CABasicAnimation animationWithKeyPath:@"position"];
    keyframeAniamton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyframeAniamton.duration = 0.3;
    keyframeAniamton.removedOnCompletion = NO;
    keyframeAniamton.fillMode = kCAFillModeForwards;
    keyframeAniamton.fromValue = [NSValue valueWithCGPoint:currentImageView.center];


    keyframeAniamton.toValue = [NSValue valueWithCGPoint:CGPointMake(currentBtn.bounds.size.width * 0.5, currentBtn.bounds.size.height * 0.5)];
    keyframeAniamton.delegate = self;
    

    
//    keyframeAniamton.autoreverses = YES;
    [currentImageView.layer addAnimation:keyframeAniamton forKey:@"CurrentImageViewPositionAniamationKey"];
    
    
    

    
    
    
    
    //上一个选中的BarItem
    TabBarItem *lastClickedBtn = self.customTabBar.subviews[self.lastSelected];
    
    UIImageView *lastImageView = lastClickedBtn.subviews[0];
    UILabel *lastLabel = lastClickedBtn.subviews[1];
    lastLabel.frame = currentLabel.frame;
     lastClickedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    lastLabel.textColor = [UIColor whiteColor];
    
    lastLabel.text = self.titles[self.lastSelected];
    NSLog(@"%@",lastLabel.text);
    self.lastImageView = lastImageView;
    
    //缩小
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"hidden"];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.fromValue = @YES;
    
    animation1.toValue = @NO;
    animation1.duration = 0.3;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    
    
    
    CABasicAnimation *keyframeAniamton1 = [CABasicAnimation animationWithKeyPath:@"position"];
    keyframeAniamton1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyframeAniamton1.duration = 0.3;
    keyframeAniamton1.removedOnCompletion = NO;
    keyframeAniamton1.fillMode = kCAFillModeForwards;
    keyframeAniamton.fromValue = [NSValue valueWithCGPoint:CGPointMake(currentBtn.bounds.size.width * 0.5, currentBtn.bounds.size.height * 0.5)];
    
    keyframeAniamton.toValue = [NSValue valueWithCGPoint:self.currentImageView.center];
    keyframeAniamton1.delegate = self;
//    
//    
//    CAAnimationGroup *groupAnimation1 = [CAAnimationGroup animation];
//    groupAnimation1.removedOnCompletion = NO;
//    groupAnimation1.fillMode = kCAFillModeForwards;
//    groupAnimation1.animations = @[animation1 ,keyframeAniamton1];
    
    [lastLabel.layer addAnimation:animation1 forKey:nil];
    [lastImageView.layer addAnimation:keyframeAniamton1 forKey:@"lastImageViewPositionAniamationKey"];
    
    self.lastSelected = self.selectedIndex;
    
    
    
    
}
-(void)createCustomTabBar
{
    _customTabBar = [[UIImageView alloc] initWithFrame:self.tabBar.frame];
    _customTabBar.frame = CGRectMake(0, 0, 320, 49);
    _customTabBar.backgroundColor = [UIColor grayColor];
    _customTabBar.userInteractionEnabled = YES;
    _customTabBar.alpha = 0.8;
    self.tabBar.userInteractionEnabled = YES;
    [self.tabBar addSubview:_customTabBar];
}
-(void)createCustomTabBarItem
{   // NSArray * titleArr = @[@"限免",@"降价",@"免费",@"专题",@"热榜"];
    

    CGFloat ItemWidth = self.tabBar.frame.size.width/self.titleVcNameArray.count;
    CGFloat ItemHeight = self.tabBar.frame.size.height;
    for (int i = 0; i<5 ;i++)
    {
        TabBarItem * item = [TabBarItem buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(0+i * ItemWidth,self.tabBar.bounds.origin.y, ItemWidth, ItemHeight);
       
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        [item setImage:[UIImage imageNamed:self.unselectedImages[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:self.unselectedImages[i]] forState:UIControlStateSelected];
        if (i==0) {
            item.selected = YES;
            item.titleLabel.textColor = [UIColor clearColor];
            item.imageView.center = item.center;
        }
        else
        {
            [item setTitle:[self.titleVcNameArray[i] allKeys][0] forState:UIControlStateNormal];
        }
        item.tag = 100+i;
        [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [_customTabBar addSubview:item];
    }
//    [self setTabBarItemSwitchAnimation];
}
-(void)selectItem:(TabBarItem *)item
{
    for (TabBarItem * item in _customTabBar.subviews) {
        if (item.selected) {
            self.lastSelectedBtn = item;
        }
        item.selected = NO;
    }
    item.selected = YES;
    self.selectedIndex = item.tag - 100;
}
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.delegate = self;
    
//    self.tabBar.hidden = YES;
    
    
    [self createCustomTabBar];
  
    [self createCustomTabBarItem];
//      return;
    
    [self.titleVcNameArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        NavVc *nav = [[NavVc alloc] initWithRootViewController:[self.titleVcNameArray[idx] allValues][0]];
        
        
        
        [self addChildViewController:nav];
        
    }];

    
    return;
    
    
    
    self.tabBar.barTintColor =  [UIColor grayColor];
    self.tabBar.translucent = NO;
    self.isFirst = NO;

    
    [self.titleVcNameArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[self.titleVcNameArray[idx] allValues][0]];
        
        UIViewController *firstChildVc =(UIViewController *)nav.childViewControllers.firstObject;
        //设置文字的样式
        NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
//        if (idx !=0) {
        firstChildVc.tabBarItem.title = self.titles[idx];
//        }
        firstChildVc.tabBarItem.image = [[UIImage imageNamed:self.unselectedImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        firstChildVc.tabBarItem.selectedImage =  [[UIImage imageNamed:self.unselectedImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (idx == 0) {
//            NSLog(@"%@",NSStringFromCGRect(firstChildVc.tabBarItem.image))
//            firstChildVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//            firstChildVc.tabBarItem.selectedImage =  [[self reSizeImage:[[UIImage imageNamed:self.unselectedImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] toSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            //当前选中的BarItem
//            UIButton *currentBtn = (UIButton *)self.tabBar.subviews[self.selectedIndex+1];
//            UIImageView *currentImageView = currentBtn.subviews[0];
//            UILabel *currentLabel = currentBtn.subviews[1];
            NSLog(@"%@ ",self.tabBar.subviews);
            
        }
        
        
        [firstChildVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        //设置选中文字的样式
        NSMutableDictionary * selectdTextAttrs = [NSMutableDictionary dictionary];
        selectdTextAttrs[NSForegroundColorAttributeName] = [UIColor clearColor];
        [firstChildVc.tabBarItem setTitleTextAttributes:selectdTextAttrs forState:UIControlStateSelected];
        
        
        
        [self addChildViewController:nav];
        
    }];
//     self.selectedIndex = 0;
//    self.selectedIndex = 1;
//      self.selectedIndex = 0;
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//        self.selectedIndex = 0;
//}
@end
