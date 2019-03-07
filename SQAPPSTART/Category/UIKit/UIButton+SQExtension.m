//
//  UIButton+SQExtension.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIButton+SQExtension.h"

@implementation UIButton (SQExtension)

- (void) setTitle: (NSString *) title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}


- (void) setTitle: (NSString *) title Color: (UIColor *) color {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
}


- (void)setButtonImageWithUrl:(NSString *)url {
    NSURL * loadUrl = [NSURL URLWithString:url];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:loadUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:img forState:UIControlStateNormal];
        });
    });
}

- (void)setButtonImageWithUrl:(NSString *)url withType:(UIControlState)state {
    NSURL * loadUrl = [NSURL URLWithString:url];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:loadUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:img forState:state];
        });
    });
}

-(void)startCountdownWitTime:(NSInteger)timeInt {
    __block NSInteger time = timeInt; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);//倒计时结束，关闭，设置按钮的样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"重新发送" forState:UIControlStateNormal];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{//设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
