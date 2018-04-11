//
//  AFN_FXWDemoVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/29.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "AFN_FXWDemoVC.h"
#import "AFN_FXW.h"
#import "UIImageView+WebCache.h"

@interface AFN_FXWDemoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) NSString  *strUrl;
@end

@implementation AFN_FXWDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"网络请求封装";
    
    
}

#pragma mark 下载文件
- (IBAction)downloadFile:(id)sender
{
    _strUrl = @"http://jjsj-psp.oss-cn-shanghai.aliyuncs.com/jjsj/psp/image/picture/f17316bf48b94c89895e284511037842.png";
    [AFN_FXW postDownloadFileWithUrl:_strUrl
                         resultBlock:^(BOOL success, NSDictionary *resultDic, NSString *errorMsg) {
        NSLog(@"");
    }];
    
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
