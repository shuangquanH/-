//
//  UIView+SQFrame.h
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SQFrame)

@property(assign,nonatomic)     CGFloat sqLeft;
@property(assign,nonatomic)     CGFloat sqTop;
@property (nonatomic, assign)   CGFloat sqBottom;
@property (nonatomic, assign)   CGFloat sqRight;

@property(assign,nonatomic)     CGFloat sqCenterX;
@property(assign,nonatomic)     CGFloat sqCenterY;
@property(assign,nonatomic)     CGFloat sqWidth;
@property(assign,nonatomic)     CGFloat sqHeight;
@property(assign,nonatomic)     CGSize  sqSize;
@property(assign,nonatomic)     CGPoint sqOrigin;





/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

- (UIView *)findFirstResponder;


/**
 *  距右多少
 *
 *  @param view   距离的view
 *  @param margin 距离
 */
-(float)rightMarginWithView:(UIView *)view width:(float)width margin:(float)margin;

/**
 *  距下多少
 *
 *  @param view   距离的view
 *  @param margin 距离
 */
-(float)bottomMarginWithView:(UIView *)view height:(float)height margin:(float)margin;

/**
 *  距底相同
 *
 *  @param view   距离的view
 *  @param height 高度
 */
-(float)equalBottomWithView:(UIView *)view height:(float)height;



@end

NS_ASSUME_NONNULL_END
