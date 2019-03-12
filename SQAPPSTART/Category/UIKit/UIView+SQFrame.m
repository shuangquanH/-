//
//  UIView+SQFrame.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIView+SQFrame.h"

@implementation UIView (SQFrame)

- (void)setSqCenterX:(CGFloat)sqCenterX {
    CGPoint center = self.center;
    center.x = sqCenterX;
    self.center = center;
}
- (CGFloat)sqCenterX {
    return self.center.x;
}

- (void)setSqCenterY:(CGFloat)sqCenterY {
    CGPoint center = self.center;
    center.y = sqCenterY;
    self.center = center;
}

-(CGFloat)sqCenterY {
    return self.center.y;
}

- (void)setSqLeft:(CGFloat)sqLeft {
    CGRect frame = self.frame;
    frame.origin.x = sqLeft;
    self.frame = frame;
}

-(CGFloat)sqLeft{
    return self.frame.origin.x;
}

- (void)setSqTop:(CGFloat)sqTop {
    CGRect frame = self.frame;
    frame.origin.y=sqTop;
    self.frame = frame;
}

-(CGFloat)sqTop{
    return self.sqOrigin.y;
}

- (void)setSqSize:(CGSize)sqSize {
    CGRect frame = self.frame;
    frame.size = sqSize;
    self.frame = frame;
}

-(CGSize)sqSize {
    return self.frame.size;
}

- (void)setSqOrigin:(CGPoint)sqOrigin {
    CGRect frame = self.frame;
    frame.origin = sqOrigin;
    self.frame = frame;
}

-(CGPoint)sqOrigin {
    return  self.frame.origin;
}

- (void)setSqWidth:(CGFloat)sqWidth {
    CGRect frame = self.frame;
    frame.size.width = sqWidth;
    self.frame = frame;
}

-(CGFloat)sqWidth {
    return self.frame.size.width;
}

- (void)setSqHeight:(CGFloat)sqHeight {
    CGRect frame = self.frame;
    frame.size.height = sqHeight;
    self.frame = frame;
}
-(CGFloat)sqHeight {
    return  self.frame.size.height;
}

- (void)setSqRight:(CGFloat)sqRight {
    CGRect frame = self.frame;
    frame.origin.x = sqRight - frame.size.width;
    self.frame = frame;
}

- (void)setSqBottom:(CGFloat)sqBottom {
    CGRect frame = self.frame;
    frame.origin.y = sqBottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sqRight {
    return self.sqLeft+self.sqWidth;
}
- (CGFloat)sqBottom {
    return self.sqTop+self.sqHeight;
}

-(float)rightMarginWithView:(UIView *)view width:(float)width margin:(float)margin
{
    self.sqWidth = width;
    self.sqLeft = view.sqLeft - width - margin;
    return self.sqLeft;
}

-(float)bottomMarginWithView:(UIView *)view height:(float)height margin:(float)margin;
{
    self.sqHeight = height;
    self.sqTop = view.sqTop - height - margin;
    return self.sqTop;
}

-(float)equalBottomWithView:(UIView *)view height:(float)height
{
    self.sqHeight = height;
    self.sqTop = view.sqHeight+height+(view.sqHeight - self.sqHeight);
    return self.sqTop;
}

- (BOOL)isShowingOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}



@end
