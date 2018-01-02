//
//  DBUser.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DBUser.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

NSString * const TABLE_USERINFO = @"t_userInfo";

@interface DBUser()

@property (nonatomic, strong) FMDatabase                *db;
@property (nonatomic, strong) NSString                  *dbPath;
@property (nonatomic, strong) FMDatabaseQueue           *queue;//多线程+事务
@end;

@implementation DBUser

+ (DBUser *)share
{
    static DBUser *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[DBUser alloc] init];
        [shareInstance initDB];
    });
    
    return shareInstance;
    
}

#pragma mark 打开
- (BOOL)openDB
{
    return [_db open];
}

#pragma mark 关闭
- (BOOL)closeDB
{
    return [_db close];
}

#pragma mark 删表
- (BOOL)delTable_userInfo
{
    NSString *strSql = [NSString stringWithFormat:@"drop table if exists %@", TABLE_USERINFO];
    BOOL result = [_db executeUpdate:strSql];
    if (result)
    {
        NSLog(@"删除表成功");
    }
    else
    {
        NSLog(@"删除表失败");
    }
    return result;
}

#pragma mark 创建数据库和表
- (void)initDB
{
    //1.打开or创建数据库
    //获取数据库文件的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"数据库路径:%@",docPath);
    //设置数据库名称
    _dbPath = [docPath stringByAppendingPathComponent:@"userInfo.sqlite"];
    //获取数据库
    _db = [FMDatabase databaseWithPath:_dbPath];
    if ([_db open])
    {
        NSLog(@"打开数据库成功");
        //2.创建表
        NSString *strSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, number text NOT NULL, gender text NOT NULL, age integer NOT NULL);", TABLE_USERINFO];
        BOOL result = [_db executeUpdate:strSql];
        if (result)
        {
            NSLog(@"创建表成功");
        }
        else
        {
            NSLog(@"创建表失败");
        }
    }
    else
    {
        NSString *error = [_db lastErrorMessage];
        int errCode     = [_db lastErrorCode];
        NSLog(@"打开数据库失败:%d-%@", errCode, error);
        
        //如果数据库没有打开的话 后续操作都无法进行
        //可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。
        //如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
        
        //self = nil; 不知道这样些是否可以重新获取一个单例
    }
    
    //FMDatabaseQueue要使用单例创建，这样多线程调用时，数据库操作使用一个队列，保证线程安全
    _queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    
}

#pragma mark 增
- (BOOL)addWithUserInfo:(UserInfo *)model
{
    NSString *name   = model.name;
    NSString *number = model.number;
    NSString *gender = model.gender;
    int age          = model.age;
    
    //检验参数合法性
    NSString *errLog = @"保存用户信息失败，参数不合法";
    if (name   == nil ||
        number == nil ||
        gender == nil ||
        age <=0       ||
        [gender isEqualToString:@""])
    {
        NSLog(@"%@", errLog);
        return NO;
    }
    
    //执行数据库操作
    NSString *strSql = [NSString stringWithFormat:@"INSERT INTO %@ (name, number, gender, age) VALUES (?,?,?,?)", TABLE_USERINFO];
    BOOL result      = [_db executeUpdate:strSql, name, number, gender, @(age)];
    if (result)
    {
        NSLog(@"新增数据成功 %@", TABLE_USERINFO);
    }
    else
    {
        NSLog(@"新增数据失败 %@", TABLE_USERINFO);
    }
    
    return result;
    /*
     int age = 42;
     //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
     [self.db executeUpdate:@“INSERT INTO t_student (name, age) VALUES (?,?);”,name,@(age)];
     //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
     [self.db executeUpdateWithForamat:@“insert into t_student (name,age) values (%@,%i);”,name,age];
     //3.参数是数组的使用方式
     [self.db executeUpdate:@“INSERT INTO
     t_student(name,age) VALUES  (?,?);”withArgumentsInArray:@[name,@(age              ? )]];
     */
}

#pragma mark 删
- (BOOL)deleteWithNumber:(NSString *)number
{
    //验证参数
    if (number == nil || [number isEqual:[NSNull null]] || [number isEqualToString:@""]) {
        NSLog(@"删除数据失败 参数错误");
        return NO;
    }
    
    NSString *strSql = [NSString stringWithFormat:@"delete from %@ where number = ?", TABLE_USERINFO];
    BOOL     result  = [_db executeUpdate:strSql, number];
    if (result)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    return result;
}

#pragma mark 改
- (BOOL)changeDataWithUserInfo:(UserInfo *)model whereNumber:(NSString *)number
{
    //验证参数
    NSString *errLog = @"修改数据失败 参数错误";
    if (number == nil || [number isEqual:[NSNull null]] || [number isEqualToString:@""]) {
        NSLog(@"%@", errLog);
        return NO;
    }
    
    NSString *name      = model.name;
    NSString *numberNew = model.number;
    NSString *gender    = model.gender;
    int age             = model.age;
    
    if (name      == nil ||
        numberNew == nil ||
        gender    == nil ||
        age <= 0){
        NSLog(@"%@", errLog);
        return NO;
    }
    
    NSString *strSql = [NSString stringWithFormat:@"update %@ set name = ?, number = ?, gender = ?, age = ? where number = ?", TABLE_USERINFO];
    BOOL result      = [_db executeUpdate:strSql, name, numberNew, gender, @(age), number];
    if (result)
    {
        NSLog(@"修改数据库成功");
    }
    else
    {
        NSLog(@"修改数据库失败");
    }
    return result;
}

#pragma mark 查 查询全部数据
- (NSArray *)readUserInfo
{
    //查询整个表
    NSString        *strSql = [NSString stringWithFormat:@"select * from %@", TABLE_USERINFO];
    FMResultSet  *resultSet = [_db executeQuery:strSql];
    NSMutableArray *mArr    = [[NSMutableArray alloc] init];
    
    //遍历结果集合
    while ([resultSet next])
    {
        NSString *name   = [resultSet objectForColumn:@"name"];
        NSString *gender = [resultSet objectForColumn:@"gender"];
        NSString *number = [resultSet objectForColumn:@"number"];
        int age          = [resultSet intForColumn:@"age"];
        
        UserInfo *info   = [[UserInfo alloc] init];
        info.name        = name;
        info.gender      = gender;
        info.number      = number;
        info.age         = age;
        [mArr addObject:info];
    }
    
    return mArr;
}

#pragma mark 查 查询指定数据
- (UserInfo *)readUserInfoWithNumber:(NSString *)number
{
    if (number == nil || [number isEqual:[NSNull null]] || [number isEqualToString:@""]) {
        NSLog(@"查询数据库失败 参数不合法");
        return nil;
    }
    //查询整个表
    NSString    *strSql    = [NSString stringWithFormat:@"select * from %@ where number = ?", TABLE_USERINFO];
    FMResultSet *resultSet = [_db executeQuery:strSql, number];
    
    UserInfo *info = [[UserInfo alloc] init];
    //遍历结果集合
    while ([resultSet next])
    {
        NSString *name   = [resultSet objectForColumn:@"name"];
        NSString *gender = [resultSet objectForColumn:@"gender"];
        NSString *number = [resultSet objectForColumn:@"number"];
        int age          = [resultSet intForColumn:@"age"];
        
        info.name        = name;
        info.gender      = gender;
        info.number      = number;
        info.age         = age;
        
    }
    return info;
}

#pragma mark 多线程 + 事务
- (void)testMThread
{
    WS(ws);
    //子线程对数据库进行操作，避免UI阻塞【如果这里不用子线程的话 数据很多的话 UI就会卡住】
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //操作数据库时，通过单例的dbQueue在block内执行SQL操作，block属于同步执行，执行完之后才会跳出执行操作之后的语句
        [ws.queue inDatabase:^(FMDatabase * _Nonnull db) {
            for (int i = 1 ; i <= 3000; i ++)
            {
                UserInfo *info = [[UserInfo alloc] init];
                info.name      = [NSString stringWithFormat:@"fxw_%d", i];
                info.number    = [NSString stringWithFormat:@"%d", i];
                info.age       = i;
                info.gender    = @"男";
                
                [ws addWithUserInfo:info];
            }
        }];
        
    });
    
}


@end
