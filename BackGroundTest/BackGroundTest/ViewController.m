//
//  ViewController.m
//  BackGroundTest
//
//  Created by MccRee on 2017/10/11.
//  Copyright © 2017年 YSTen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,copy) NSString *filePath;
@property(nonatomic,strong) NSMutableArray *mArr;
@property(nonatomic,strong) UILabel *textView;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) NSUserDefaults *ud;
@property(nonatomic,assign) BOOL ter;
@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ud = [NSUserDefaults standardUserDefaults];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeGround)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillTerminate)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    return self;
}

- (NSMutableArray *)mArr{
    if (_mArr == nil) {
        NSArray *tempArr = [self.ud objectForKey:@"mArr"];
        if (tempArr) {
            _mArr = [tempArr mutableCopy];
        }else{
            _mArr = [[NSMutableArray alloc]init];
        }
    }
    return _mArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.btn];
    [self showTextView];
}

- (void)clearUD{
    [self.ud setObject:nil forKey:@"mArr"];
    [self showTextView];
}

- (void)showTextView{
    NSArray *arr = [self.ud objectForKey:@"mArr"];
    NSString *result = @" ";
    for (NSString *str in arr) {
        result = [result stringByAppendingFormat:@"%@\n",str];
    }
//    NSString *ter = [self.ud valueForKey:@"Terminate"];
//    if (ter) {
//        result = [result stringByAppendingString:ter];
//    }
    self.textView.text = result;
}

- (void)applicationWillEnterForeGround{
    [self showTextView];
    self.ter = NO;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.ter) {
        [self.mArr addObject:[NSString stringWithFormat:@"%@",@"Disappear"]];
        [self.ud setObject:self.mArr forKey:@"mArr"];
    }
   
}

- (void)applicationWillTerminate{
    self.ter = YES;
    [self.mArr addObject:[NSString stringWithFormat:@"%@%zd",@"Terminate",self.mArr.count]];
    [self.ud setObject:self.mArr forKey:@"mArr"];
}

- (void)applicationDidEnterBackground{
    [self.mArr addObject:[NSString stringWithFormat:@"%@%zd",@"EnterBackground",self.mArr.count]];
    [self.ud setObject:self.mArr forKey:@"mArr"];

}

- (UILabel *)textView{
    if (_textView == nil) {
        _textView = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 355, 500)];
        _textView.backgroundColor = [UIColor lightGrayColor];
        _textView.textColor = [UIColor whiteColor];
        _textView.numberOfLines = 0;

    }
    return _textView;
}

- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 600, 100, 30)];
        _btn.backgroundColor = [UIColor redColor];
        [_btn addTarget:self action:@selector(clearUD) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
