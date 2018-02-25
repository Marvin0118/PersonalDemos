
//
//  UDPServerViewController.m
//  Socket-TCPdemo
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/13.
//  Copyright © 2017年 doublej. All rights reserved.
//
//#define HOST @"192.168.1.108"
#define PORT  8008

#import "UDPServerViewController.h"
#import "ClientViewController.h"

@interface UDPServerViewController ()

@property(nonatomic,strong) UILabel *testLabel;

@end

@implementation UDPServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, 200, 200)];
    self.testLabel.layer.borderWidth = 1.0f;
    self.testLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.testLabel.numberOfLines = 0;
    [self.view addSubview:self.testLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 服务器socket实例化  在0x1234端口监听数据
    serverSocket=[[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [serverSocket bindToPort:PORT error:nil];
    if (![serverSocket beginReceiving:nil]) {
        [serverSocket close];
        NSLog(@"Error starting server");
        return;
    }
}

// 网络连接成功后  自动回调
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
   NSLog(@"已连接到用户:ip:%@",[[NSString alloc]initWithData:address encoding:NSUTF8StringEncoding]);
}
//

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString *datastr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *receiveMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 将数据回写给发送数据的用户
    NSLog(@"debug >>>> %@",receiveMsg);
    self.testLabel.text = receiveMsg;
    [sock sendData:[[NSString stringWithFormat:@"服务器收到%@发来的数据",datastr] dataUsingEncoding:NSUTF8StringEncoding] toAddress:address withTimeout:-1 tag:300];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
