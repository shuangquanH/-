//
//  Y_BrokenLine.m
//  Exchange
//
//  Created by ly on 2018/11/15.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_BrokenLine.h"

@interface Y_BrokenLine ()

@property (nonatomic, assign) CGContextRef context;

@end

@implementation Y_BrokenLine

/**
 *  根据context初始化画线
 */
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if(self)
    {
        self.context = context;
    }
    return self;
}

- (void)draw
{
    if(!self.context)
    {
        return;
    }
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(self.context, self.timeLineColor.CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(self.context, self.lineWidth);
    //设置虚线绘制起点
    CGContextMoveToPoint(self.context, self.startPoint.x, self.startPoint.y);
    //设置虚线绘制终点
    CGContextAddLineToPoint(self.context, self.endPoint.x, self.endPoint.y);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {self.dash,self.gap};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(self.context, 0, arr, 2);
    CGContextStrokePath(self.context);
}

@end
