//
//  UITableView+SQAddHeadTip.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UITableView+SQAddHeadTip.h"
#import "SQTimeDelay.h"

@implementation UITableView (SQAddHeadTip)
- (void)addTip:(NSString *)title stayTime:(NSInteger)stime height:(CGFloat)height color:(UIColor *)tcolor backgroundColor:(UIColor *)bcolor font:(UIFont *)font {
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(KAPP_WIDTH / 2.0, 0, 0, height)];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.font = font;
    headLabel.textColor = tcolor;
    headLabel.backgroundColor = bcolor;
    
    [UIView animateWithDuration:0.3 animations:^{
        headLabel.frame = CGRectMake(0, 0, KAPP_WIDTH, height);
        self.tableHeaderView = headLabel;
    } completion:^(BOOL finished) {
        headLabel.text = title;
    }];
    
    [SQTimeDelay timeDelayWithTime:stime complet:^{
        [UIView animateWithDuration:0.3 animations:^{
            headLabel.frame = CGRectMake(0, 0, KAPP_WIDTH, 0);
        }completion:^(BOOL finished) {
            self.tableHeaderView = nil;
        }];
    }];
    
}

- (void)addTipWithTitle:(NSString   *)title {
    [self addTip:title stayTime:2.0 height:30 color:KCOLOR_WHIT backgroundColor:[UIColor orangeColor] font:KFONT(13)];
}
@end
