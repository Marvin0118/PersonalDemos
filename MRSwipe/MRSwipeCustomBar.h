//
//  MRSwipeCustomBar.h
//  YSTSearchKit
//
//  Created by MccRee on 2017/12/15.
//

#import <UIKit/UIKit.h>


@protocol MRSwipeCustomBarDelegate <NSObject>

/**
 点击了滑动块
 */
- (void)customBarBtnSelectedIndex:(NSInteger)selectedIndex;

@end

@interface MRSwipeCustomBar : UIScrollView

@property (nonatomic, weak) id<MRSwipeCustomBarDelegate>mrDelegate;



/**
 标题之间的间距
 */
@property(nonatomic,assign) CGFloat barItemMargin;

/**
 btn默认颜色
 */
@property(nonatomic,strong) UIColor *btnTitleColor;

/**
 btn选中时颜色
 */
@property(nonatomic,strong) UIColor *btnTitleSelectedColor;

/**
 btn默认字体大小,default 15
 */
@property(nonatomic,strong) UIFont *btnTitleFont;

/**
 btn选中字体大小,default 18
 */
@property(nonatomic,strong) UIFont *btnTitleSelectedFont;

/**
 滑块长度,default 30
 */
@property(nonatomic,assign) CGFloat bottomSliderLength;

- (void)hidden;

- (void)show;

- (void)setBtnTitle:(NSString *)title;

- (void)setSelectedItem:(NSInteger)index;

- (void)selectedFirstBtn;
@end
