//
//  CustomView.m
//  ViewAnimationMasonry
//
//  Created by MccRee on 2018/4/24.
//  Copyright © 2018年 mccree. All rights reserved.
//

#import "CustomView.h"
#import <Masonry/Masonry.h>

@interface CustomView()

@property(nonatomic,strong) UIView *testView;
@property(nonatomic,strong) MASConstraint *wid;
@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setTheConstraints];
    
}


- (void)setUpUI{
    self.testView = [[UIView alloc]init];
    self.testView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.testView];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@5);
        _wid = make.width.mas_equalTo(@20);
        make.left.top.mas_equalTo(self);
    }];
}

- (void)setTheConstraints{
    
}

- (void)show{
//    //设置初始状态
//    _wid.mas_equalTo(@0);
//    // 立即让约束生效
//    [self layoutIfNeeded];
    _wid.mas_equalTo(150.5f);
    [UIView animateWithDuration:5.0f animations:^{
        [self layoutIfNeeded];
    }];
}




@end
