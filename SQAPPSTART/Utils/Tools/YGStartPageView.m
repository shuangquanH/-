//
//  YGStartPageView.m
//  YogeeLiveShop
//
//  Created by zhangkaifeng on 16/7/27.
//  Copyright © 2016年 ccyouge. All rights reserved.
//

#import "YGStartPageView.h"


@implementation YGStartPageView
{
    UIPageControl *_pageControl;
}
- (instancetype)initWithLocalPhotoNamesArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        _localPhotoNamesArray = array;
        [self configUI];
    }
    return self;
}

+ (void)showLaunchWithViewController:(UIViewController *)vc {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"lauchedStartPageView"]) {
        NSMutableArray *imageNameArray = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            [imageNameArray addObject:[NSString stringWithFormat:@"guide_bg%d", i+1]];
        }
        [YGStartPageView showWithLocalPhotoNamesArray:imageNameArray];
    }
}

-(void)configUI
{
    self.frame = [UIScreen mainScreen].bounds;
    
    //scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KAPP_WIDTH, KAPP_HEIGHT)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KAPP_WIDTH *(_localPhotoNamesArray.count + 1), KAPP_HEIGHT);
    scrollView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    //page
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, KAPP_HEIGHT -  40, KAPP_WIDTH, 10)];
    page.currentPage = 0;
    page.currentPageIndicatorTintColor = kCOLOR_999;
    page.pageIndicatorTintColor = KCOLOR_LIGHTBACK;
    page.numberOfPages = _localPhotoNamesArray.count;
    [self addSubview:page];
    _pageControl = page;
    
    
    for (int i = 0; i<_localPhotoNamesArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        imageView.frame = CGRectMake(i*KAPP_WIDTH, 0, KAPP_WIDTH, KAPP_HEIGHT);
        imageView.image = [UIImage imageNamed:_localPhotoNamesArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        if (i == _localPhotoNamesArray.count-1) {
            UIButton *noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            noticeBtn.frame = CGRectMake((KAPP_WIDTH-100)/2.0, _pageControl.frame.origin.y-50, 100, 35);
            [noticeBtn setImage:[UIImage imageNamed:@"guide_enter_button"] forState:UIControlStateNormal];
            [noticeBtn addTarget:self action:@selector(didLaunched) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:noticeBtn];
        }
    }
}

+(void)showWithLocalPhotoNamesArray:(NSArray *)array
{
    [[[self alloc]initWithLocalPhotoNamesArray:array] showView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/KAPP_WIDTH;
    //如果不是最后一页，正常变page
    if (index != _localPhotoNamesArray.count)
    {
        _pageControl.currentPage = index;
    }
    //如果是最后一页,把自己干掉
    else
    {
        [self didLaunched];
    }
}

-(void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float index = scrollView.contentOffset.x/KAPP_WIDTH;
    
    if (index>_localPhotoNamesArray.count - 1)
    {
        float offsetX = scrollView.contentOffset.x - KAPP_WIDTH *(_localPhotoNamesArray.count - 1);
        float alpha = 1.0/KAPP_WIDTH * offsetX;
        scrollView.alpha = 1 - alpha;
    } else {
        scrollView.alpha = 1;
    }
    
}

/** 引导页执行完毕  */
- (void)didLaunched {
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"lauchedStartPageView"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lauchedStartPageView" object:nil];
    [self removeFromSuperview];
}
@end
