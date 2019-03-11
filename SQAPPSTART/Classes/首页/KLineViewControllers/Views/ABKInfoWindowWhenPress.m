//
//  ABKInfoWindowWhenPress.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ABKInfoWindowWhenPress.h"
#import "SQTransformTime.h"


@implementation ABKInfoWindowWhenPress {
    UILabel *timeLabel;
    UILabel *oppenLb;
    UILabel *colseLb;
    UILabel *heightLb;
    UILabel *lowLb;
    UILabel *thePrice;
    UILabel *thePresent;
    UILabel *theVolume;
    NSMutableArray *labelArr;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        labelArr = [NSMutableArray array];
        
        
        self.backgroundColor = KCOLOR_ALPHA(@"999999", 0.3);
        timeLabel = [self creatLabel];
        oppenLb = [self creatLabel];
        colseLb = [self creatLabel];
        heightLb = [self creatLabel];
        lowLb = [self creatLabel];
        thePrice = [self creatLabel];
        thePresent = [self creatLabel];
        theVolume = [self creatLabel];
        
        [self makeConstraint];
        
    }
    return self;
}

- (void)makeConstraint {
    [labelArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:10 leadSpacing:10 tailSpacing:10];
    [labelArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10);
    }];
}

- (void)setModel:(Y_KLineModel *)model {
    if (_model!=model) {
        _model = model;
        
        NSString *formatter = @"yyyy-MM-dd HH:mm";
        NSString *time = [SQTransformTime getDateWithTimeIntervalStr:model.Date withFormatter:formatter];
        
        
        timeLabel.text =    [NSString stringWithFormat:@"时间:%@", time];
        oppenLb.text =      [NSString stringWithFormat:@"开:%@", model.Open];
        colseLb.text =      [NSString stringWithFormat:@"收:%@", model.Close];
        heightLb.text =     [NSString stringWithFormat:@"高:%@", model.High];
        lowLb.text =        [NSString stringWithFormat:@"低:%@", model.Low];
        thePrice.text =     [NSString stringWithFormat:@"涨跌额:%@", model.UPClosePrice];
        thePresent.text =   [NSString stringWithFormat:@"涨跌幅:%@", [self getPercentString]];
        theVolume.text =    [NSString stringWithFormat:@"成交量:%.2fK", model.Volume];
        

    }
    
}

- (NSString *)getPercentString {
    CGFloat percentFloat;
    NSNumber *close = self.model.Close;
    NSNumber *open = self.model.Open;
    if (close>=open) {
        percentFloat = [close floatValue]/[open floatValue];
        return [NSString stringWithFormat:@"%.2f%%", percentFloat];
    } else {
        percentFloat = [open floatValue]/[close floatValue];
        return [NSString stringWithFormat:@"-%.2f%%", percentFloat];
    }
}


- (UILabel  *)creatLabel {
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.font = KSYSFONT(8);
    label.textColor = KCOLOR_BLACK;
    [labelArr addObject:label];
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
