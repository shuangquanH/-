//
//  DepthView.h
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DepthGroupModel;
@class DepthModel;

@protocol DepthViewDelegate <NSObject>

@optional
- (void)depthViewLongPressDepthModel:(DepthModel *)depthModel;

@end

@interface DepthView : UIView

@property (nonatomic, strong) DepthGroupModel *depthGroupModel;

@property (nonatomic, assign) id<DepthViewDelegate> delegate;

- (void)reloaView;
- (void)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition;

@end
