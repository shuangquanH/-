//
//  UIImageView+SQExtension_m.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIImageView+SQExtension_m.h"
#import "YYWebImage.h"

@implementation UIImageView (SQExtension_m)

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setImageWithUrl:(NSString *)url {
    UIImage *placeImage = [UIImage imageNamed:@"defaultImage"];
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeImage options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.image = image ? image: placeImage;
    }];
}

@end
