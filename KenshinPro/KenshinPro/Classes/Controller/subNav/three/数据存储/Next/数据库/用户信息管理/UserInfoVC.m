//
//  UserInfoVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "UserInfoVC.h"
#import "DBUser.h"
#import "UserInfo.h"


@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (nonatomic, strong) DBUser                 *user;


@end

@implementation UserInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息管理";
    _user = [DBUser share];//初始化数据库
}

- (UserInfo *)info
{
    NSString *name   = _txtName.text;
    NSString *number = _txtNumber.text;
    NSString *gender = _txtGender.text;
    int age          = [_txtAge.text intValue];
    
    UserInfo *info = [[UserInfo alloc] init];
    info.name      = name;
    info.number    = number;
    info.gender    = gender;
    info.age       = age;
    return info;
}

#pragma mark 增
- (IBAction)add:(id)sender
{
    [_user addWithUserInfo:[self info]];
}

#pragma mark 删
- (IBAction)del:(id)sender
{
    UserInfo *info = [self info];
    [_user deleteWithNumber:info.number];
}

#pragma mark 改
- (IBAction)change:(id)sender
{
    UserInfo *info = [self info];
    [_user changeDataWithUserInfo:info whereNumber:info.number];
}

#pragma mark 查【全】
- (IBAction)select:(id)sender
{
    NSArray *arrInfo = [_user readUserInfo];
    arrInfo = nil;
}

#pragma mark 查【where】
- (IBAction)selectWhere:(id)sender
{
    UserInfo *info    = [self info];
    UserInfo *tmpInfo = [_user readUserInfoWithNumber:info.number];
    tmpInfo = nil;
}

#pragma mark 删表
- (IBAction)delTable:(id)sender
{
    [_user delTable_userInfo];
}

#pragma mark 打开数据库[初始化单例时已开启]
- (IBAction)open:(id)sender
{
    BOOL flag = [_user openDB];
    if (flag) {
        NSLog(@"数据库开启成功");
    }
}

#pragma mark 关闭
- (IBAction)close:(id)sender
{
    BOOL flag = [_user closeDB];
    if (flag) {
        NSLog(@"数据库关闭成功");
    }
}

#pragma mark 多线程操作 插入100条数据
- (IBAction)mThreadInsertManyData:(id)sender
{
    [_user testMThread];
    
    
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
