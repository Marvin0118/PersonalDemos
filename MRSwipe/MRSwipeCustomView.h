//
//  MRSwipeCustomView.h
//  YSTSearchKit
//
//  Created by MccRee on 2017/12/15.
//

#import <UIKit/UIKit.h>
#import "MRSwipeCustomBar.h"

@protocol MRSwipeCustomViewDelegate <NSObject>

/**
 停止滚动
 */
- (void)MRSwipeViewDidEndScroll;

@end
@interface MRSwipeCustomView : UIView

@property(nonatomic,weak) id<MRSwipeCustomViewDelegate> delegate;

/**
 滚动条背景色
 */
@property(nonatomic,strong) UIColor *scrollBarBackgroundColor;

/**
 自定义滚动条
 */
@property(nonatomic,strong) MRSwipeCustomBar *customBar;

/**
 当前停留在第几个控制器上
 */
@property(nonatomic,assign) NSInteger indexVC;

- (void)addSubViewController:(UIViewController *)viewController;

@end
