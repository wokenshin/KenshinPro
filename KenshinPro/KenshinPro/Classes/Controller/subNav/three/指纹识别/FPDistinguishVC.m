//
//  FPDistinguishVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/29.
//  Copyright © 2017年 Kenshin. All rights reserved.


#import "FPDistinguishVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface FPDistinguishVC ()

@end

@implementation FPDistinguishVC


/**
 from http://blog.csdn.net/www_131374/article/details/70303311【只有代码】 funcOne
 from http://www.jianshu.com/p/67fd93408517                   【差强人意】 funcTwo
 from http://www.jianshu.com/p/d44b7d85e0a6                   【目前最好的一篇文章】
 补充：在 连续5次输入指纹错误之后，将无法使用touchID 此时 authError.code = -8， 但是并非设备不支持touchID 经测试 6P 不支持指纹 返回 authError.code = -7
 
 必要描述：
 1.验证手机是否支持指纹识别
 2.手机是否有设置指纹解锁
 3.验证指纹
 4.如果验证错误次数达到上限[5/6次]->弹出系统解锁界面，只有解锁成功之后 才能据需使用 TouchID 验证指纹
 5.如果一开始就发现验证次数达到上限 就走4
 6.如果手机不支持 TouchID 可以考虑直接跳转到 系统解锁界面 or 其他方案
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"指纹识别";
//    [self funcOne];//方法1 简单粗暴 功能单一
    [self funcTwo];//方法2更好一些 但是仍有不完善的地方
    
}

- (void)funcOne
{
    //初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    //这个设置的使用密码的字体，当text=@""时，按钮将被隐藏
    context.localizedFallbackTitle = @"";
    //这个设置的取消按钮的字体
    context.localizedCancelTitle   = @"取消";
    //错误对象
    NSError *error   = nil;
    NSString *result = @"需要验证您的touch ID";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"验证成功");
            }
            else
            {
                NSLog(@"验证失败 error:%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        NSLog(@"切换到其他APP，系统取消验证Touch ID");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择其他验证方式，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        NSLog(@"不支持指纹识别，LOG出错误详情");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        NSLog(@"error %@",error.localizedDescription);
    }
    
}

- (void)funcTwo
{
    LAContext *myContext = [[LAContext alloc] init];
    // 这个属性是设置指纹输入失败之后的弹出框的选项
    myContext.localizedFallbackTitle = @"忘记密码";
    
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"请按住Home键完成验证";
    // MARK: 判断设备是否支持指纹识别
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            if(success)
            {
                NSLog(@"指纹认证成功");
            }
            else
            {
                NSLog(@"指纹认证失败，%@",error.description);
                NSLog(@"%ld", (long)error.code); // 错误码 error.code
                switch (error.code)
                {
                    case LAErrorAuthenticationFailed: // Authentication was not successful, because user failed to provide valid credentials
                    {
                        NSLog(@"授权失败"); // -1 连续三次指纹识别错误
                    }
                        break;
                    case LAErrorUserCancel: // Authentication was canceled by user (e.g. tapped Cancel button)
                    {
                        NSLog(@"用户取消验证Touch ID"); // -2 在TouchID对话框中点击了取消按钮
                    }
                        break;
                    case LAErrorUserFallback: // Authentication was canceled, because the user tapped the fallback button (Enter Password)
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理"); // -3 在TouchID对话框中点击了输入密码按钮
                        }];
                        
                    }
                        break;
                    case LAErrorSystemCancel: // Authentication was canceled by system (e.g. another application went to foreground)
                    {
                        NSLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                    }
                        break;
                    case LAErrorPasscodeNotSet: // Authentication could not start, because passcode is not set on the device.
                        
                    {
                        NSLog(@"设备系统未设置密码"); // -5
                    }
                        break;
                    case LAErrorTouchIDNotAvailable: // Authentication could not start, because Touch ID is not available on the device
                    {
                        NSLog(@"设备未设置Touch ID"); // -6
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled: // Authentication could not start, because Touch ID has no enrolled fingers
                    {
                        NSLog(@"用户未录入指纹"); // -7
                    }
                        break;
                        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
                    case LAErrorTouchIDLockout: //Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite 用户连续多次进行Touch ID验证失败，Touch ID被锁，需要用户输入密码解锁，先Touch ID验证密码
                    {
                        NSLog(@"Touch ID被锁，需要用户输入密码解锁"); // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
//                        fxw add code
                        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                                  localizedReason:@"是不是你的手指哟？"
                                            reply:^(BOOL success, NSError * _Nullable error) {

                        }];
                        
                    }
                        break;
                    case LAErrorAppCancel: // Authentication was canceled by application (e.g. invalidate was called while authentication was in progress) 如突然来了电话，电话应用进入前台，APP被挂起啦");
                    {
                        NSLog(@"用户不能控制情况下APP被挂起"); // -9
                    }
                        break;
                    case LAErrorInvalidContext: // LAContext passed to this call has been previously invalidated.
                    {
                        NSLog(@"LAContext传递给这个调用之前已经失效"); // -10
                    }
                        break;
#else
#endif
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        NSLog(@"设备不支持指纹");
        NSLog(@"%ld", (long)authError.code);
        switch (authError.code)
        {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"Authentication could not start, because Touch ID has no enrolled fingers");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"Authentication could not start, because passcode is not set on the device");
                break;
            }
            case LAErrorTouchIDLockout:
            {
//                fxw add code
                [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                          localizedReason:@"您的TouchID多次输错，需要解锁验证"
                                    reply:^(BOOL success, NSError * _Nullable error) {

                }];
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
    }
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
