//
//  DBUser.h
//  KenshinPro
//
//  Created by kenshin van on 2017/12/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

/**
 用户信息数据库 这里只做一个简单的演示，其实可以不断扩充功能
 */
@interface DBUser : NSObject

//推荐使用第三种方式操作数据

//方式一 这种写法最笨
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *number;
//@property (nonatomic, strong) NSString *age;
//@property (nonatomic, strong) NSString *gender;

//方式二 这种写法其实也不好
//@property (nonatomic, strong) NSDictionary *dicUserInfo;

//方式三 定义一个模型数据类 如 UserInfo
@property (nonatomic, strong) UserInfo  *userInfo;

//获取单例[在单例中 创建数据库]
+ (DBUser *)share;
- (BOOL)openDB;
- (BOOL)closeDB;
- (BOOL)delTable_userInfo;//删除表

//增
- (BOOL)addWithUserInfo:(UserInfo *)model;
//删
- (BOOL)deleteWithNumber:(NSString *)number;
//改
- (BOOL)changeDataWithUserInfo:(UserInfo *)model whereNumber:(NSString *)number;
//查1
- (NSArray *)readUserInfo;
//查2
- (UserInfo *)readUserInfoWithNumber:(NSString *)number;
//测试多线程+事务
- (void)testMThread;

@end
