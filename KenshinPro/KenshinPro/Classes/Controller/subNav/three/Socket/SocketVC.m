//
//  SocketVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/12.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SocketVC.h"
#import "SmartSocketManager.h"

@interface SocketVC ()

@property (weak, nonatomic) IBOutlet UITextField                *txtHost;
@property (weak, nonatomic) IBOutlet UITextField                *txtPort;
@property (weak, nonatomic) IBOutlet UITextField                *txtSendMsg;

@property (nonatomic, strong) SmartSocketManager                *socketManager;
@property (nonatomic, strong) NSString                          *host;
@property (nonatomic, assign) int                               port;

@end

@implementation SocketVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"socket";
    
}

#pragma mark 连接
- (IBAction)clickConnectServer:(id)sender
{
    _host = _txtHost.text;
    _port = [_txtPort.text intValue];
    //获取 ip port 初始化socketManager
    _socketManager = [SmartSocketManager shareInstanceWitpHostIp:_host port:_port];
    
    //链接
    WS(ws);
    [_socketManager connect:^(CODE_SOCKETCONN code) {
        NSString *tips = @"见鬼了";
        switch (code) {
            case CODE_SOCKETCONN_CONNECTING:
            {
                tips = @"正在链接...";
            }
            break;
            case CODE_SOCKETCONN_OK:
            {
                tips = @"连接成功";
            }
                break;
            case CODE_SOCKETCONN_FAILD:
            {
                tips = @"连接失败";
            }
                break;
            case CODE_SOCKETCONN_DISCONNECTED:
            {
                tips = @"断开连接";
            }
                break;
            default:
            {
                
            }
                break;
        }
        [ws toastBottom:tips];
        
    }];
    
}

#pragma mark 发送
- (IBAction)clickSendMsg:(id)sender
{
    NSString *msg = _txtSendMsg.text;
    if ([msg isEqualToString:@""]) {
        [self toastBottom:@"发送消息不能为空"];
        return;
    }
    
    WS(ws);
    [_socketManager sendMsg:msg timeout:-1 withBlock:^(CODE_SOCKET code, NSData *responseData) {
        NSString *tips = @"见鬼了";
        switch (code)
        {
            case CODE_SOCKET_WRITED:
            {
                tips = @"成功写入";
            }
                break;
            case CODE_SOCKET_RESPONSE:
            {
                //将二进制数据转成字符串 or 其他模型数据
                NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                tips = [NSString stringWithFormat:@"%@:%@", @"收到响应", string];
            }
                break;
            case CODE_SOCKET_TIMEOUT:
            {
                tips = @"请求超时";
            }
                break;
            default:
                break;
        }
        [ws toastBottom:tips];
        
    }];
    
}

#pragma mark 断开连接
- (IBAction)clickDisconnect:(id)sender
{
    [_socketManager disConnect];
    
}




- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
