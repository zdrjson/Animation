//
//  JumpStarView.h
//  JumpStarDemo
//
//  Created by 张德荣 on 16/5/6.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, STATE) {
    NONMARK,
    Mark,
};

@interface JumpStarView : UIView
- (void)animate;
@property (nonatomic, assign) STATE state;
@property (nonatomic, strong) UIImage *markedImage;
@property (nonatomic, strong) UIImage *non_markedImage;


@end
