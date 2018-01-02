//
//  SmartSocketManager.m
//  SmartDevice
//
//  Created by kenshin on 2017/9/5.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import "SmartSocketManager.h"
#import "GCDAsyncSocket.h"

@interface SmartSocketManager()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket            *gcdSocket;
@property (nonatomic, strong) NSString                  *Khost;
@property (nonatomic, assign) int                       Kport;

@property (nonatomic, copy)   M2MSocketConnBlock        connCallback;
@property (nonatomic, copy)   M2MSocketSendBlock        sendSocketCallback;

@property (nonatomic, assign, readwrite) BOOL           isConnected;//是否已连接

@property (nonatomic, assign) BOOL                      isRequestTimeout;//是否请求超时

@property (nonatomic, assign) NSTimeInterval            responseTimeout;//请求超时

@end

@implementation SmartSocketManager

+ (instancetype)shareInstanceWitpHostIp:(NSString *)hostIp port:(int)port
{
    static dispatch_once_t onceToken;
    static SmartSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
        instance.Khost = hostIp;
        instance.Kport = port;
    });
    return instance;
    
}

- (void)initSocket
{
    _gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

- (BOOL)isConnected
{
    if (_gcdSocket)
    {
        return [_gcdSocket isConnected];
    }
    return NO;
    
}

#pragma mark - 对外的一些接口

//建立连接
- (void)connect:(M2MSocketConnBlock)resultBlock
{
    self.connCallback = resultBlock;
    
    [_gcdSocket disconnect];//断开一次 避免重复连接 如果这里不断开 在重复连接的时候 就会连接失败
    
    //这里的bool返回的是能否链接，成功表示可以链接，失败表示由于设备出了问题导致不能链接
    if ([_gcdSocket connectToHost:_Khost onPort:_Kport error:nil])
    {
        resultBlock(CODE_SOCKETCONN_CONNECTING);//正在建立连接
    }
    else
    {
        resultBlock(CODE_SOCKETCONN_FAILD);//连接失败
    }
    
}

//断开连接
- (void)disConnect
{
    [_gcdSocket disconnect];
}


//发送消息
- (void)sendMsg:(NSString *)msg timeout:(NSTimeInterval)time withBlock:(M2MSocketSendBlock)resultBlock
{
    if (msg == nil || [msg isEqual:[NSNull null]])
    {
        NSLog(@"M2MSocket send socket error, msg == nil or msg == null");
        return;
    }
    
    NSData *data  = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    //第二个参数，写超时时间
    [_gcdSocket writeData:data withTimeout:time tag:110];
    
    self.sendSocketCallback = resultBlock;
    _responseTimeout = time;
    
}

//发送消息
- (void)sendData:(NSData *)msg timeout:(NSTimeInterval)time withBlock:(M2MSocketSendBlock)resultBlock
{
    if (msg == nil || [msg isEqual:[NSNull null]])
    {
        NSLog(@"M2MSocket send socket error, msg == nil or msg == null");
        return;
    }
    
    //当超时时间为 -1 时 即为不做超时限制
    [_gcdSocket writeData:msg withTimeout:time tag:110];
    self.sendSocketCallback = resultBlock;
    _responseTimeout = time;//设置超时时间如果设置为 -1的话 则为不设置超时
    
}


//监听最新的消息
- (void)pullTheMsg
{
    //监听读数据的代理  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    
    //注意 在连接成功的代理方法里面一定要写上如下代码，否则接收不到消息的，这个是读取消息用的
    [_gcdSocket readDataWithTimeout:-1 tag:110];
    
}

#pragma mark - GCDAsyncSocketDelegate
#pragma mark 连接成功时 触发
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);
    
    if (_connCallback)
    {
        _connCallback(CODE_SOCKETCONN_OK);//连接成功
    }
    
    [self pullTheMsg];
    
    //心跳写在这...
}

#pragma mark 断开连接时 触发
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    
    if (_connCallback)
    {
        _connCallback(CODE_SOCKETCONN_DISCONNECTED);//断开连接
    }
    //断线重连写在这...
    [_gcdSocket connectToHost:_Khost onPort:_Kport error:nil]; //后期可以根据需求设置 例如重连最多10次
}

#pragma mark 发送成功时 触发
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"写成功的回调,tag:%ld",tag);
    
    if (_sendSocketCallback)
    {
        _sendSocketCallback(CODE_SOCKET_WRITED, nil);
    }
    
    WS(ws);//做一个_responseTimeouts的超时， 如果发出数据 _responseTimeouts后 还没有收到 响应 就默认算是超时
    ws.isRequestTimeout = YES;
    if (_responseTimeout > 0)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_responseTimeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (ws.isRequestTimeout)
            {
                if (_sendSocketCallback)
                {
                    [ws disConnect];
                    _sendSocketCallback(CODE_SOCKET_TIMEOUT, nil);
                }
            }
        });
    }
    
}

#pragma mark 服务器响应时 触发
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    //    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //    NSLog(@"收到消息：%@",msg);
    
    [self pullTheMsg];
    _isRequestTimeout = NO;//这样就不会触发 超时了
    if (_sendSocketCallback)
    {
        _sendSocketCallback(CODE_SOCKET_RESPONSE, data);
    }
    
}

#pragma mark 接手到服务器消息时 触发
//读超时 当调用 [_socket readDataWithTimeout:n tag:x]; n秒后触发
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    //当发送小时 如果设置了 readTimeout 那么 到时间后 会触发这里的回调 此时会自动断开连接[触发断开的回调]
    //[_gcdSocket readDataWithTimeout:10 tag:110];
    
    //NSLog(@"读超时 通常不需要设置超时时间， 但是如果不调用 readDataWithTimeout 方法的话 将无法监听响应");
    return -1;//翻译下注释 看下这里返回值的意义
    
}

//写超时 当调用 [_socket writeData:data withTimeout:n tag:x]; n秒后触发
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    //就是发送数据的时候设置的超时时间，
    NSLog(@"写超时");
    return -1;
}

//这里还没有实现 超时的代理

////分段去获取消息的回调
//- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
//{
//    NSLog(@"读的回调,length:%ld,tag:%ld",partialLength,tag);
//
//}
//
////为上一次设置的读取数据代理续时 (如果设置超时为-1，则永远不会调用到)
//-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    NSLog(@"来延时，tag:%ld,elapsed:%f,length:%ld",tag,elapsed,length);
//
//
//    return 10;
//}


@end
