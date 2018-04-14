//
//  MRSwipeCustomBar.m
//  YSTSearchKit
//
//  Created by MccRee on 2017/12/15.
//

#import "MRSwipeCustomBar.h"
#import <Masonry/Masonry.h>
//屏幕高度
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width
//适配iPhoneX的宏
#define k_iPhoneX (W == 375.f && H == 812.f ? YES : NO)
#define k_StatusBarHeight   (k_iPhoneX ? 44.f : 20.f)
#define k_NavigationBarHeight   44.f
#define k_TabbarHeight  (k_iPhoneX ? (49.f+34.f) : 49.f)
#define k_StatusBarAndNavigationBarHeight  (k_iPhoneX ? 88.f : 64.f)

static CGFloat const toolBarItemMargin = 0; // 标题之间的间距

@interface MRSwipeCustomBar()<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *buttonsArr;
@property(nonatomic,strong) UIButton *selectedBtn;
@property(nonatomic,strong) UIView *bottomSlider;

@end

@implementation MRSwipeCustomBar
- (void)dealloc{
//    NSLog(@"%s",__func__);
}

- (NSMutableArray *)buttonsArr {
    if (!_buttonsArr) {
        _buttonsArr = [NSMutableArray array];
    }
    return _buttonsArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        _barItemMargin = toolBarItemMargin;
        _bottomSliderLength = 30.0;
    }
    return self;
}

- (void)setBtnTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    button.titleLabel.font = self.btnTitleFont;
    [button setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
    [button setTitleColor:self.btnTitleSelectedColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonsArr addObject:button];
    
    //初始化滑块位置
    if (self.buttonsArr.count < 2) {
        [self addSubview:self.bottomSlider];
        self.bottomSlider.backgroundColor = [UIColor blueColor];
        [self.bottomSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.bottomSliderLength);
            make.height.mas_equalTo(2);
            make.bottom.mas_equalTo(button).offset(-2);
            make.centerX.mas_equalTo(button.mas_centerX);
        }];
    }
}


- (void)buttonClick:(UIButton *)sender {
    NSInteger index = [self.buttonsArr indexOfObject:sender];
    if ([self.mrDelegate respondsToSelector:@selector(customBarBtnSelectedIndex:)]) {
        [self.mrDelegate customBarBtnSelectedIndex:index];
    }
}

- (void)setSelectedItem:(NSInteger)index {
    UIButton *button = self.buttonsArr[index];
    if (button == self.selectedBtn) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        button.selected = YES;
        button.titleLabel.font = self.btnTitleSelectedFont;
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font = self.btnTitleFont;
        self.selectedBtn = button;
        
        // 计算偏移量
        CGFloat offsetX = button.center.x - W * 0.5;
        if (offsetX < 0) offsetX = 0;
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - W;
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        if (self.contentSize.width > [UIScreen mainScreen].bounds.size.width) {
            // 滚动标题滚动条
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
        
        //移动滑块
        [self.bottomSlider mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.bottomSliderLength);
            make.height.mas_equalTo(2);
            make.bottom.mas_equalTo(button).offset(-2);
            make.centerX.mas_equalTo(button.mas_centerX);
        }];
        
        [self layoutIfNeeded];
    }];
}

- (void)selectedFirstBtn{
    UIButton *button = self.buttonsArr[0];
    button.selected = YES;
    button.titleLabel.font = self.btnTitleSelectedFont;
    self.selectedBtn.selected = NO;
    self.selectedBtn.titleLabel.font = self.btnTitleFont;
    self.selectedBtn = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnH = k_NavigationBarHeight;
    CGFloat btnX = self.barItemMargin;
    for (NSInteger i = 0; i < self.buttonsArr.count; i++) {
        UIButton *button = self.buttonsArr[i];
        if (i == 0) {
            btnX = 0;
        }
        button.frame = CGRectMake(btnX, 0, W/3, btnH);
        btnX += button.frame.size.width + toolBarItemMargin;
    }
    self.contentSize = CGSizeMake(btnX, 0);
}

#pragma mark Public
- (void)hidden{
    [self setHidden:YES];
}

- (void)show{
    [self setHidden:NO];
}

#pragma mark Set&Get
- (UIView *)bottomSlider{
    if (!_bottomSlider) {
        _bottomSlider = [[UIView alloc]init];
    }
    return _bottomSlider;
}

- (UIColor *)btnTitleColor{
    if (!_btnTitleColor) {
        _btnTitleColor = [UIColor blackColor];
    }
    return _btnTitleColor;
}

- (UIColor *)btnTitleSelectedColor{
    if (!_btnTitleSelectedColor) {
        _btnTitleSelectedColor = [UIColor blackColor];
    }
    return _btnTitleSelectedColor;
}

- (UIFont *)btnTitleFont{
    if (!_btnTitleFont) {
        _btnTitleFont = [UIFont systemFontOfSize:15];
    }
    return _btnTitleFont;
}

- (UIFont *)btnTitleSelectedFont{
    if (!_btnTitleSelectedFont) {
        _btnTitleSelectedFont = [UIFont systemFontOfSize:18];
    }
    return _btnTitleSelectedFont;
}

@end
