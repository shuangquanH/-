//
//  UITabBar+SQExtension.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UITabBar+SQExtension.h"

@implementation UITabBar (SQExtension)

- (void)showBadgeOnItemIndex:(int)index{
    float tabbarItemNums = 4.0;//tabbarItem的数目
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIImageView *badgeView = [[UIImageView alloc]init];
    badgeView.image = [UIImage imageNamed:@"home_fuction_dian"];
    badgeView.tag = 10032 + index;
    CGRect tabFrame = self.frame;
    //确定小红点x轴的相对位置
    float percentX = (index + 0.6) / tabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width) - 3;
    CGFloat y = -6;
    badgeView.frame = CGRectMake(x, y, 18, 18);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2;
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIImageView *subView in self.subviews) {
        if (subView.tag == 10032 + index) {
            [subView removeFromSuperview];
        }
    }
}


@end
