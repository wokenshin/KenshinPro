//
//  SocketBaseVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/22.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SocketBaseVC.h"
#import "GCDAsyncSocket.h"

#import "SocketVC.h"

//从入门到牛逼哄哄
@interface SocketBaseVC ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextView             *txtViewReceiveMsg;
@property (weak, nonatomic) IBOutlet UITextField            *txtHostIP;
@property (weak, nonatomic) IBOutlet UITextField            *txtPort;
@property (weak, nonatomic) IBOutlet UITextField            *txtSendMsg;



@property (nonatomic, strong) GCDAsyncSocket                *gcdSocket;
@property (nonatomic, strong) NSString                      *host;
@property (nonatomic, assign) NSUInteger                    port;
@property (nonatomic, assign) NSUInteger                    reconnTimes;//重连
@property (nonatomic, strong) NSTimer                       *timerBeat;//心跳

//扩展 可以设置这两个参数 来控制器 我们的socket 是否需要 重连机制 和 心跳机智， 同时可以把 对应的参数也提取出来方便修改 如重连次数， 心跳周期等
@property (nonatomic, assign) BOOL                          isBeat;
@property (nonatomic, assign) BOOL                          isReconn;

@end



/**
 大致流程
 1.设置 ip 和 端口 然后初始化 GCDAsyncSocket 并连接
 2.连接成功后 开启心跳功能【其实就是周期性地给服务器发送消息】
 3.连接成功后 可以给服务器发送消息
 4.在连接断开的时候 关闭【心跳】，判断是否是主动断开，如果不是 就进行重连【重连次数最多为5次，每次间隔2的N次方秒，连接成功后 回复重连次数为0】
 */
@implementation SocketBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"socket基础-核心";
    
    //初始化
    _gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    _txtHostIP.text = @"172.16.9.58";
    _txtPort.text   = @"8080";
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self beatStop];
    
}

#pragma mark 连接->走代理
- (IBAction)clickBtnConnectServer:(id)sender
{
    _host = _txtHostIP.text;
    _port = [_txtPort.text integerValue];
    
    if ([_host isEqualToString:@""] || _port <1000) {
        [self toastBottom:@"链接参数错误"];
        return;
    }
    
    [_gcdSocket disconnect];//断开一次 避免重复连接 如果这里不断开 在重复连接的时候 就会连接失败
    
    //这里的bool返回的是能否链接，成功表示可以链接，失败表示由于设备出了问题导致不能链接
    if ([_gcdSocket connectToHost:_host onPort:_port error:nil])
    {
        [self toastBottom:@"正在连接..."];
    }
    else
    {
        [self toastBottom:@"连接失败"];
    }
        
}

#pragma mark 断开
- (IBAction)clickBtnDisconnectServer:(id)sender
{
    [_gcdSocket disconnect];
}


#pragma mark 发送消息
- (IBAction)clickBtnSendMsg:(id)sender
{
    NSString *msg = _txtSendMsg.text;
    if ([msg isEqualToString:@""]) {
        [self toastBottom:@"发送消息是不能为空"];
        return;
    }
    
    NSData *data  = [msg dataUsingEncoding:NSUTF8StringEncoding];//字符串 转 二进制
    [_gcdSocket writeData:data withTimeout:-1 tag:110];//第二个参数，写超时时间
    
}

#pragma mark 接收消息[在代理中被调用]
- (void)receiveMsg:(NSData *)msgData
{
    NSString *msg = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];
    _txtViewReceiveMsg.text = msg;
    [self toastBottom:msg];
    
}


//监听最新的消息
- (void)pullTheMsg
{
    //监听读数据的代理  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    
    //注意 在连接成功的代理方法里面一定要写上如下代码，否则接收不到消息的，这个是读取消息用的
    [_gcdSocket readDataWithTimeout:-1 tag:110];
    
}

#pragma mark 心跳[目的是为了与服务器保持链接]
- (void)beatStar
{
    if (_timerBeat == nil)
    {
        _timerBeat = [NSTimer scheduledTimerWithTimeInterval:10
                                                      target:self
                                                    selector:@selector(beatFunctionKeepConn)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

//心跳方法 周期性向服务器发送消息 保持连接
- (void)beatFunctionKeepConn
{
    NSData *data  = [@"beat..." dataUsingEncoding:NSUTF8StringEncoding];
    [_gcdSocket writeData:data withTimeout:-1 tag:110];
    
}

- (void)beatStop
{
    [_timerBeat invalidate];
    _timerBeat = nil;
}

//恢复重连参数
- (void)resetReconnParam
{
    _reconnTimes = 0;
}

#pragma mark - GCDAsyncSocketDelegate
#pragma mark 连接成功时 触发
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSString *tips = [NSString stringWithFormat:@"连接成功,host:%@,port:%d",host,port];
    [self toastBottom:tips];
    [self pullTheMsg];//不写就收不到响应
    [self resetReconnParam];//连接成功之后 重连机制复位
    [self beatStar];//心跳写在这...【目的是为了与服务器保存连接，不然过一段时间不发消息服务器有可能会主动断开连接】
    
}

#pragma mark 断开连接时 触发
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    [self beatStop];
    if (err)//非正常断开,包括服务器断开，手机端断网等情况， ,经测试，如果服务器断开连接，客户端在第一次连接时，连接失败 也会走这里
    {
        //这里还可以在做一层优化-手机端断网可以不重连,连上网后自动重连【本demo就不搞这么多了】
        
        //重连
        WS(ws);
        NSInteger second =  pow(2, _reconnTimes);//pow(x, y) 返回 x的y次方
        NSUInteger time = _reconnTimes++;
        
        if (time <= 5)//会重连5次
        {
            NSLog(@"重连次数 %zd, 等待%zds后重连", _reconnTimes, second);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ws.gcdSocket connectToHost:ws.host onPort:ws.port error:nil]; //后期可以根据需求设置 例如重连最多10次
                //2的N次方秒重连一次 连续5次 reConnTimes == 5 时 都失败就放弃 链接成功后 reConnTimes = 0
                [ws toastBottom:[NSString stringWithFormat:@"重连中...%ld", 5 - time]];
            });
        }
        else
        {
            [ws resetReconnParam];//复位
        }
    }
    else//如果是用户主动断开的，那么就不用重连了
    {
        //正常断开
        [self toastBottom:@"已主动断开连接..."];
    }
    
}

#pragma mark 发送成功时 触发
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSString *tips = [NSString stringWithFormat:@"发送成功, tag:%ld",tag];
    [self toastBottom:tips];
    
}

#pragma mark 接手到服务器消息时 触发
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [self pullTheMsg];//不写的话 在收到第一次响应之后 就收不到响应了
    [self receiveMsg:data];
    NSLog(@"收到服务器响应");
    
}



#pragma mark - 进阶
- (IBAction)clickBtnUpLevel:(id)sender
{
    //这里的东西其实并不多，但是简单的需求已经够用了  复杂的需求 需要结合具体需求来实现
    SocketVC *vc = [[SocketVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
