//
//  BaseFunctionVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/21.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseFunctionVC.h"

@interface BaseFunctionVC ()

@property (weak, nonatomic) IBOutlet UITextField *labTop;


@end

@implementation BaseFunctionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaeFunctionVCUI];
    
}

- (void)initBaeFunctionVCUI
{
    self.navigationItem.title = @"父类控制器基本功能";
    
}

- (IBAction)btnPop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma 导航栏左边按钮
- (IBAction)leftNavTitleAction:(id)sender
{
    WS(ws);
    [self setNavLeftBtnWithName:@"左标题"
            andClickResultblock:^{
        [ws toast:@"左边 标题按钮被点击"];
    }];
    
}

- (IBAction)leftTitleColorAction:(id)sender
{
    WS(ws);
    [self setNavLeftBtnWithName:@"左标题"
                  andTitleColor:[UIColor redColor]
            andClickResultblock:^{
        [ws toast:@"左边 有色标题按钮被点击"];
    }];
    
}

- (IBAction)leftImgAction:(id)sender
{
    WS(ws);
    [self setNavLeftBtnWithImg:@"radiobtn_selected" andClickResultblock:^{
        [ws toast:@"左边 图片按钮被点击"];
    }];
    
}

#pragma 导航栏右边按钮
- (IBAction)rightNavTitleAction:(id)sender
{
    WS(ws);
    [self setNavRightBtnWithName:@"右标题" andClickResultblock:^{
        [ws toast:@"右边 标题按钮被点击"];
    }];
    
}

- (IBAction)rightTitleColroAction:(id)sender
{
    WS(ws);
    [self setNavRightBtnWithName:@"右标题"
                   andTitleColor:[UIColor yellowColor]
             andClickResultblock:^{
        [ws toast:@"右边 有色标题按钮被点击"];
    }];
    
}

- (IBAction)rightImgAction:(id)sender
{
    WS(ws);
    [self setNavRightBtnWithImg:@"radiobtn_unselect" andClickResultblock:^{
        [ws toast:@"右边 图片按钮被点击"];
    }];
    
}

#pragma mark - 菊花
- (IBAction)showJuHuaAAA:(id)sender
{
    [self showJuHua:@""];
    
    WS(ws);//3s后 隐藏菊花
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws hideJuHua];
    });
    
}

- (IBAction)showErrorAAA:(id)sender
{
    [self showError:@"错误提示"];
    
}

- (IBAction)showMessageAAA:(id)sender
{
    [self showMessage:@"消息提示, 长度有限"];
    
}

- (IBAction)showMessage12313:(id)sender
{
    [self showMessageMLine:@"消息提示， 可多行"];
    
}

- (IBAction)toastOne:(id)sender
{
    [self toast:@"显示在中显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅间"];
    
}

- (IBAction)toastTwo:(id)sender
{
    [self toastBottom:@"显示在底部 奥斯显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅显示在底部 奥斯卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅卡大神覅和覅哦啊或发哦一我哈佛我啊哈佛覅"];
    
}

- (IBAction)btnGetContactsPhoneNo:(id)sender
{
    WS(ws);
    [self selectPhoneNoByContactsWithResultPhoneNo:^(NSString *phoneNo) {
        ws.labTop.text = phoneNo;
        [ws toast:@"一行代码 获取通讯录号码"];
    }];
    
}

#pragma mark - 发短信
- (IBAction)btnSendMSM:(id)sender
{
    [self sendMSMPhoneNos:@[@"18312345678"]
                    title:@"测试发送短信"
                  content:@"短信内容，明天我们一起去打篮球吧"
    resultBlock:^(BOOL sendSuccess) {
        if (sendSuccess)
        {
            NSLog(@"发送短信成功");
        }
        else
        {
            NSLog(@"发送短信失败");
        }
        
    }];
    
}

- (IBAction)sysetmAlertOne:(id)sender
{
    WS(ws);
    [self alertSystemTitle:@"我是标题" message:@"我是内容哈哈" OK:^{
        [ws toast:@"我是回调事件"];
    }];
    
}

- (IBAction)systemAlertTwo:(id)sender
{
    WS(ws);
    [self alertSystemTitle:@"我是标题"
                   message:@"我是内容 哈了个哈"
    OK:^{
        [ws toast:@"click OK"];
    } Cancel:^{
        [ws toast:@"click Cancel"];
    }];
    
}

#pragma mark 打电话 [这个地方如果快速点击按钮的话，会响应多次，应该避免这种情况]
- (IBAction)btnCallNo:(UIButton *)btn
{
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    
    [self callNo:@"10086"];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
