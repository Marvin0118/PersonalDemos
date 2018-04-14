//
//  MRSwipeCustomView.m
//  YSTSearchKit
//
//  Created by MccRee on 2017/12/15.
//

#import "MRSwipeCustomView.h"
#import "UIColor+MRK.h"

//屏幕高度
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width
//适配iPhoneX的宏
#define k_iPhoneX (W == 375.f && H == 812.f ? YES : NO)
#define k_StatusBarHeight   (k_iPhoneX ? 44.f : 20.f)
#define k_NavigationBarHeight   44.f
#define k_TabbarHeight  (k_iPhoneX ? (49.f+34.f) : 49.f)
#define k_StatusBarAndNavigationBarHeight  (k_iPhoneX ? 88.f : 64.f)


static CGFloat const toolBarHeight = 44;
@interface MRSwipeCustomView()<MRSwipeCustomBarDelegate, UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *subControllersArr;
@property(nonatomic,strong) UIScrollView *pagesScrollView;


@end

@implementation MRSwipeCustomView
- (void)dealloc{
//    NSLog(@"%s",__func__);
}

/**懒加载*/
- (NSMutableArray *)subControllersArr {
    if (!_subControllersArr) {
        _subControllersArr = [NSMutableArray array];
    }
    return _subControllersArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.backgroundColor = [UIColor whiteColor];
    self.customBar = [[MRSwipeCustomBar alloc] initWithFrame:CGRectMake(0, 0, W, toolBarHeight)];
    self.customBar.btnTitleColor = [UIColor colorWithHexString:@"333333"];
    self.customBar.btnTitleSelectedColor = [UIColor colorWithHexString:@"0085CF"];
    self.customBar.btnTitleFont = [UIFont systemFontOfSize:15];
    self.customBar.btnTitleSelectedFont = [UIFont systemFontOfSize:15];
    self.customBar.delegate = self;
    [self addSubview:self.customBar];
    
    if (!self.pagesScrollView) {
        UIScrollView *pagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, toolBarHeight, W, H - toolBarHeight - k_StatusBarAndNavigationBarHeight)];
        pagesScrollView.delegate = self;
        pagesScrollView.pagingEnabled = YES;
        pagesScrollView.showsVerticalScrollIndicator = NO;
        pagesScrollView.showsHorizontalScrollIndicator = NO;
        self.pagesScrollView = pagesScrollView;
        [self addSubview:pagesScrollView];
    }
}

- (void)addSubViewController:(UIViewController *)viewController {
    [self.customBar setBtnTitle:viewController.title];
    [self.subControllersArr addObject:viewController];
    CGFloat pageY = 0;
    CGFloat pageW = self.bounds.size.width;
    CGFloat pageX = pageW;
    CGFloat pageH = CGRectGetHeight(self.pagesScrollView.frame);
    CGSize pageContentSize = CGSizeMake(pageW, pageH);
    
    for (int i = 0; i < self.subControllersArr.count; i++) {
        UIViewController *rootVc = [self.subControllersArr objectAtIndex:i];
        rootVc.view.frame = CGRectMake(pageX * i, pageY, pageW, pageH);
        [self.pagesScrollView addSubview:rootVc.view];
        pageContentSize.width = CGRectGetMaxX(rootVc.view.frame);
    }
    self.pagesScrollView.contentSize = pageContentSize;
}

#pragma mark --> UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offX = scrollView.contentOffset.x;
    CGFloat pageW = self.bounds.size.width;
    if (scrollView != self.customBar) {
        NSInteger index = offX/pageW;
        [self.customBar setSelectedItem:index];
        self.indexVC = index;
    }
    
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}

#pragma mark - scrollView 滚动停止
- (void)scrollViewDidEndScroll {
    if ([self.delegate respondsToSelector:@selector(MRSwipeViewDidEndScroll)]) {
        [self.delegate MRSwipeViewDidEndScroll];
    }
}

#pragma mark --> toolBarDelegate
- (void)customBarBtnSelectedIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:0.25 animations:^{
        [self.customBar setSelectedItem:selectedIndex];
        self.pagesScrollView.contentOffset = CGPointMake(selectedIndex * W, 0);
    } completion:^(BOOL finished) {
        self.indexVC = selectedIndex;
        [self scrollViewDidEndScroll];
    }];
}

#pragma mark Set&Get
- (void)setScrollBarBackgroundColor:(UIColor *)scrollBarBackgroundColor{
    _scrollBarBackgroundColor = scrollBarBackgroundColor;
    self.customBar.backgroundColor = scrollBarBackgroundColor;
}

@end
