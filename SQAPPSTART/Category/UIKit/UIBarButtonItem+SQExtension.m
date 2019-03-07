//
//  UIBarButtonItem+SQExtension.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIBarButtonItem+SQExtension.h"

@implementation UIBarButtonItem (SQExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 35, 35);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)createRightWordBarButtonForDelegate:(id)delegate title:(NSString *)title textColor:(UIColor *)color action:(SEL)action{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    [rightButton setFrame:CGRectMake(0, 0, size.width + 10, 44)];
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];;
    [rightButton setTitleColor:color forState:UIControlStateNormal];
    [rightButton addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    return rightItem;
}

@end
