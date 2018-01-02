//
//  SmartSocketManager.h
//  SmartDevice
//
//  Created by kenshin on 2017/9/5.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartSocketManager : NSObject

@property (nonatomic, assign, readonly) BOOL                      isConnected;//是否已连接

#pragma mark 连接时相关定义
typedef NS_ENUM(NSInteger, CODE_SOCKETCONN)
{
    CODE_SOCKETCONN_CONNECTING          = 1,//正在建立连接
    CODE_SOCKETCONN_OK                  = 2,//连接成功
    CODE_SOCKETCONN_FAILD               = 3,//连接失败
    CODE_SOCKETCONN_DISCONNECTED        = 4 //断开连接
    
};


#pragma mark 发送数据时相关定义
typedef NS_ENUM(NSInteger, CODE_SOCKET)
{
    
    CODE_SOCKET_WRITED                  = 1,//成功写入
    CODE_SOCKET_RESPONSE                = 2,//收到响应
    CODE_SOCKET_TIMEOUT                 = 3 //请求超时
};


typedef void (^M2MSocketConnBlock)(CODE_SOCKETCONN code);
typedef void (^M2MSocketSendBlock)(CODE_SOCKET code, NSData *responseData);

/**
 根据IP地址和端口号获取 M2MSocket实例
 
 @param hostIp  服务器主机地址
 @param port    端口号
 @return        M2MSocket
 */
+ (instancetype)shareInstanceWitpHostIp:(NSString *)hostIp port:(int)port;

/**
 建立连接
 
 @param resultBlock M2MSocketConnBlock
 */
- (void)connect:(M2MSocketConnBlock)resultBlock;


/**
 断开连接
 */
- (void)disConnect;


/**
 发送数据
 
 @param msg         data数据
 @param time        超时时间
 @param resultBlock M2MSocketSendBlock
 */
- (void)sendData:(NSData *)msg timeout:(NSTimeInterval)time withBlock:(M2MSocketSendBlock)resultBlock;


/**
 发送字符串
 
 @param msg         字符串
 @param time        超时时间 传-1的话 就不会主动断开连接 >0 无论发送消息是否成功 超时时间到后会断开连接
 @param resultBlock M2MSocketSendBlock
 */
- (void)sendMsg:(NSString *)msg timeout:(NSTimeInterval)time withBlock:(M2MSocketSendBlock)resultBlock;


/**
 监听最新的消息
 */
- (void)pullTheMsg;


@end
