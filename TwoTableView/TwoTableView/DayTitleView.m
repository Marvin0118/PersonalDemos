//
//  DayTitleView.m
//  TwoTableView
//
//  Created by MccRee on 2017/9/7.
//  Copyright © 2017年 MccRee. All rights reserved.
//

#import "DayTitleView.h"

//屏幕高度
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width


@interface DayTitleView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DayTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = [UIColor lightGrayColor];
    self.frame = CGRectMake(0, 0, W, 74);
    [self addSubview:self.scrollView];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]init];
        CGFloat btnX = W/3 * i;
        btn.frame = CGRectMake(btnX, 0, W/3, 73);
        CGFloat r = (50 + arc4random() % 255)/255;
        CGFloat g = (100 + arc4random() % 255)/255;
        CGFloat b = (150 + arc4random() % 255)/255;
        btn.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        
        [self.scrollView addSubview:btn];
    }
}

- (void)btnPressed:(UIButton *)btn{
    
}


#pragma mark Set&Get
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.frame = CGRectMake(0, 0, W, 74);
    }
    return _scrollView;
}
@end
