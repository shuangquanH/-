//
//  UILabel+SQExtension.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UILabel+SQExtension.h"
#import "NSString+SQCheckString.h"

@implementation UILabel (SQExtension)

- (void)setFont:(UIFont *)font Color: (UIColor *) color {
    self.adjustsFontSizeToFitWidth = YES;
    if (font) {
        self.font = font;
    }
    if (color) {
        self.textColor = color;
    }
}

- (void)changeLineSpaceWithSpace:(float)space {
    if (![self.text isNullStr]) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        self.lineBreakMode = NSLineBreakByCharWrapping;
    }
}

- (void)changeWordSpaceWithSpace:(float)space {
    if (![self.text isNullStr]) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        self.lineBreakMode = NSLineBreakByTruncatingTail;
    }
}

- (void)changeSpacewithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    if (![self.text isNullStr]) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        self.lineBreakMode = NSLineBreakByTruncatingTail;
    }
}

@end
