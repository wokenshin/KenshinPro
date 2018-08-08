//
//  JavaLearnVC.m
//  KenshinPro
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JavaLearnVC.h"

NSString * const BaseUrl_Kenshin = @"http://172.16.3.174:8080/";


/**
 本类用于测试 我服务端开发的程序「内网」
 */
@interface JavaLearnVC ()

@end

@implementation JavaLearnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initJavaLearnVCUI];
    [self loadData];
    
}

- (void)initJavaLearnVCUI{
    self.title = @"测试我的后端接口";
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    //项目1
    [self addDataWithTitle:@"hello"  andDetail:@"get请求 返回的是一个字符串 非json格式"];
    [self addDataWithTitle:@"userInfo"  andDetail:@"get请求 返回json数据"];
    [self addDataWithTitle:@"yoyoyo"  andDetail:@"我没实现这个接口,会返回404"];
    [self addDataWithTitle:@"login"  andDetail:@"post请求"];
    
    //项目2
    [self addDataWithTitle:@"MySQL"  andDetail:@"增删改查的测试"];
    [self addDataWithTitle:@"token"  andDetail:@"测试库 zjj返回令牌"];
    
    
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"token"]){
        [self postMethodGetToken];
        return;
    }
    if ([title isEqualToString:@"MySQL"]){
        [self getMethodMySQL];
        return;
    }
    if ([title isEqualToString:@"hello"]){
        [self getMethodWith:@"hello"];
        return;
    }
    if ([title isEqualToString:@"userInfo"]){
        [self getMethodWith:@"userInfo"];
        return;
    }
    if ([title isEqualToString:@"yoyoyo"]){
        [self getMethodWith:@"yoyoyo"];
        return;
    }
    if ([title isEqualToString:@"login"]){
        [self postLogin];
        return;
    }
    [self toastBottom:@"没有实现该功能"];
    
}

//打印请求结果
- (void)printResult:(NSData * _Nullable)data error:(NSError * _Nullable)error reqUrl:(NSString *)reqUrl{
    
    NSLog(@"请求:%@", reqUrl);
    if (data == nil || [data isEqual:[NSNull null]]) {
        NSLog(@"请求失败 %@", error);
    }
    else{
        //注意 如果这里后台返回的不是json格式的话 解析出来的结果就会出错 可能解析出nil
        NSDictionary *dicResp = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (dicResp == nil) {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"响应 : %@", str);
        }
        else{
            NSLog(@"响应 : %@", dicResp);
        }
    }
}

#pragma mark - HTTP GET请求
- (void)getMethodWith:(NSString *)method{
    
    NSString *reqUrl      = [NSString stringWithFormat:@"%@%@", BaseUrl_Kenshin, method];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:reqUrl]];
    
    WS(ws);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [ws printResult:data error:error reqUrl:reqUrl];
    }];
    [task resume];
    
}

#pragma mark - HTTP POST请求
- (void)postLogin{
    
    NSString *reqUrl             = [NSString stringWithFormat:@"%@login", BaseUrl_Kenshin];
    NSURLSession *session        = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqUrl]];
    
    //设置request
    request.HTTPMethod = @"post";
    //设置请求数据
    request.HTTPBody   = [@"name=kenshin&pwd=123456" dataUsingEncoding:NSUTF8StringEncoding];
    
    WS(ws);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [ws printResult:data error:error reqUrl:reqUrl];
    }];
    [task resume];
    
}

- (void)getMethodMySQL{
    
    NSString *reqUrl             = [NSString stringWithFormat:@"%@/user/list", BaseUrl_Kenshin];
    NSURLSession *session        = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqUrl]];
    
    //设置request
    request.HTTPMethod = @"get";
    //设置请求数据
//    request.HTTPBody   = [@"name=kenshin&pwd=123456" dataUsingEncoding:NSUTF8StringEncoding];
    
    WS(ws);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [ws printResult:data error:error reqUrl:reqUrl];
    }];
    [task resume];
    
}

- (void)postMethodGetToken
{
    NSString *reqUrl             = @"http://sjgx.gyfc.net.cn:8026/token";
    NSURLSession *session        = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqUrl]];
    
    //设置request
    request.HTTPMethod = @"post";
    //设置请求数据
    request.HTTPBody   = [@"client_id=2018041200011&client_secret=a7a20785-1ec8-4ec3-bc22-9e6da9cdbbfb1&grant_type=client_credentials" dataUsingEncoding:NSUTF8StringEncoding];
    
    WS(ws);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [ws printResult:data error:error reqUrl:reqUrl];
    }];
    [task resume];
}
@end
