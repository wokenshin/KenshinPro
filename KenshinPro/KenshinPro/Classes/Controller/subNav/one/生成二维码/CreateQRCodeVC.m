//
//  CreateQRCodeVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CreateQRCodeVC.h"
#import "UIImage+FXW.h"

//原生代码 通过 分类实现 二维码的生成
@interface CreateQRCodeVC ()

@property (weak, nonatomic) IBOutlet UITextField *txtContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation CreateQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"生成二维码";
    
}

- (IBAction)clickBtnCreateQRCode:(id)sender
{
    NSString *content = _txtContent.text;
    if ([content isEqualToString:@""]) {
        NSLog(@"请输入内容");
        return;
    }
    
    UIImage *img1  = [UIImage jy_QRCodeFromString:content size:200];
    _imgView.image = img1;
    
}




@end
