//
//  NSMutableAttributedString+AppendImage.m
//  QingYouProject
//
//  Created by qwuser on 2018/5/31.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import "NSMutableAttributedString+AppendImage.h"

@implementation NSMutableAttributedString (AppendImage)


- (void)appendImage:(UIImage    *)image withIndex:(NSInteger)index {
    [self appendImage:image withIndex:index imageBounds:CGRectMake(0, -4, image.size.width, image.size.height)];
}



- (void)appendImage:(UIImage    *)image withType:(SQAppendImageType)type {
    if (type==SQAppendImageInLeft) {
        [self appendImage:image withIndex:0 imageBounds:CGRectMake(0, -4, image.size.width, image.size.height)];
    } else {
        [self appendImage:image withIndex:self.string.length imageBounds:CGRectMake(4, -4, image.size.width, image.size.height)];
    }
}

- (void)appendImage:(UIImage *)image withIndex:(NSInteger)index imageBounds:(CGRect)imageBounds {
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = imageBounds;
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [self insertAttributedString:attachmentString atIndex:index];
}

@end
