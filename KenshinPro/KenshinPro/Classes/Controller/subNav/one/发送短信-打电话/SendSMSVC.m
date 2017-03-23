//
//  5000 Duǎnxìn SendSMSVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/22.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SendSMSVC.h"

#import <MessageUI/MessageUI.h>//导入发短信头文件 类库

@interface SendSMSVC ()<MFMessageComposeViewControllerDelegate>

//短信内容
@property (weak, nonatomic) IBOutlet FXW_TextView *contentView;

//手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;


@end

@implementation SendSMSVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"发送短信-打电话";
    _contentView.placeholder = @"请输入短信内容";
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置push的vc的导航栏标题颜色为黑色【发送短信的时候显示】
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20],
                                                           NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark 发送短信
- (IBAction)btnSendSMS:(id)sender
{
    if ([_phoneNo.text isEqualToString:@""])
    {
        [self showError:@"请输入手机号"];
        return;
    }
    if ([_contentView.text isEqualToString:@""])
    {
        [self showError:@"请输入短信内容"];
        return;
    }
    [self showMessageView:@[_phoneNo.text] title:@"发送短信啦啦啦" body:_contentView.text];
    
}

#pragma mark 发短信--->从vc返回后 会调用 代理:messageComposeViewController
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        [self alertSystemTitle:@"提示" message:@"该设备不支持短信功能" OK:^{}];
    }
}

#pragma mark 发短信 pop代理
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultSent:
        {
            [self alertSystemTitle:@"提示" message:@"短信发送成功" OK:^{}];
        }
            break;
        case MessageComposeResultFailed:
        {
            [self alertSystemTitle:@"提示" message:@"短信发送失败" OK:^{}];
        }
            break;
        case MessageComposeResultCancelled:
        {
            [self alertSystemTitle:@"提示" message:@"短信发送被用户取消" OK:^{}];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 打电话
- (IBAction)ckickBtnTellPhone:(id)sender
{
    if ([_phoneNo.text isEqualToString:@""])
    {
        [self showError:@"请输入拨号号码"];
        return;
    }
    
//    NSString *protocol = [NSString stringWithFormat:@"tel://%@", _phoneNo.text];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
    //等同注释掉的代码
    [self callNo:_phoneNo.text];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
