//
//  ViewController.m
//  Danmu
//
//  Created by MccRee on 2018/1/8.
//  Copyright © 2018年 mccree. All rights reserved.
//

#import "ViewController.h"
#import <HJDanmaku/HJDanmakuView.h>
#import <HJDanmaku/HJDanmakuModel.h>
#import "DanmuModel.h"
#import "DemoDanmakuCell.h"
@interface ViewController ()<HJDanmakuViewDateSource, HJDanmakuViewDelegate>

@property (nonatomic,strong) HJDanmakuView *danmakuView;   //弹幕层
@property (nonatomic, strong) NSArray *danmakus;
@property (nonatomic, strong) dispatch_source_t timerPolling;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    HJDanmakuConfiguration *config = [[HJDanmakuConfiguration alloc] initWithDanmakuMode:HJDanmakuModeLive];
    self.danmakuView = [[HJDanmakuView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:config];
    self.danmakuView.dataSource = self;
    self.danmakuView.delegate = self;
    [self.danmakuView registerClass:[DemoDanmakuCell class] forCellReuseIdentifier:@"cell"];
//    self.danmakuView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.danmakuView];
    
    self.danmakus = [NSArray array];
    if (!self.danmakuView.isPrepared) {
        [self.danmakuView prepareDanmakus:nil];
    }
}

- (void)dealloc {
    [self.danmakuView stop];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark - delegate

- (void)prepareCompletedWithDanmakuView:(HJDanmakuView *)danmakuView {
    [self.danmakuView play];
}

- (BOOL)danmakuView:(HJDanmakuView *)danmakuView shouldSelectCell:(HJDanmakuCell *)cell danmaku:(HJDanmakuModel *)danmaku {
    return danmaku.danmakuType == HJDanmakuTypeLR;
}

- (void)danmakuView:(HJDanmakuView *)danmakuView didSelectCell:(HJDanmakuCell *)cell danmaku:(HJDanmakuModel *)danmaku {
    NSLog(@"select=> %@", cell.textLabel.text);
}

#pragma mark - dataSource
- (CGFloat)danmakuView:(HJDanmakuView *)danmakuView widthForDanmaku:(HJDanmakuModel *)danmaku{
    DanmuModel *model = (DanmuModel *)danmaku;
    return [model.text sizeWithAttributes:@{NSFontAttributeName: model.textFont}].width + 1.0f;
}

- (HJDanmakuCell *)danmakuView:(HJDanmakuView *)danmakuView cellForDanmaku:(HJDanmakuModel *)danmaku{
    DanmuModel *model = (DanmuModel *)danmaku;
    DemoDanmakuCell *cell = [danmakuView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = HJDanmakuCellSelectionStyleDefault;
    cell.alpha = 1.0;
    if (model.selfFlag) {
        cell.zIndex = 30;
        cell.layer.borderWidth = 0.5;
        cell.layer.borderColor = [UIColor redColor].CGColor;
    }
    cell.textLabel.font = model.textFont;
    cell.textLabel.textColor = model.textColor;
    cell.textLabel.text = model.text;
    return cell;
}

- (void)randomSendNewDanmaku {
    DanmuModel *danmakuModel = [[DanmuModel alloc] initWithType:HJDanmakuTypeLR];
    NSInteger index = arc4random()%10;
    NSArray *arr = @[@"天啦噜",@"2333333333",@"老铁双击666",@"火钳刘明",@"回头就是反杀",@"我来守护这个弹幕",@"飞-----------------------追!!!",@"叔叔我们不约",@"qwewqeqweqweqwe",@"请问请问请问企鹅去搭顺风车V"];
    CGFloat r = arc4random()%255 / 255.0 ;
    CGFloat g = arc4random()%255 / 255.0 ;
    CGFloat b = arc4random()%255 / 255.0 ;
    if (index >8) {
        danmakuModel.selfFlag = YES;
    }
    danmakuModel.text = arr[index];
    danmakuModel.textFont = [UIFont systemFontOfSize:17];
    danmakuModel.textColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    [self.danmakuView sendDanmaku:danmakuModel forceRender:NO];
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timerPolling = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.1 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timerPolling, start, interval, 0);
    dispatch_source_set_event_handler(self.timerPolling, ^{
        [weakSelf randomSendNewDanmaku];
    });
    dispatch_resume(self.timerPolling);
}


@end
