//
//  FMDBVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FMDBVC.h"
#import "FMDatabase.h"
#import "UserInfoVC.h"

//本例参考【基础】 http://www.jianshu.com/p/7ac1c6eb63ed
//sql语法        http://www.runoob.com/sqlite/sqlite-syntax.html

//建议直接看这篇【基础+多线程+事务】 http://blog.csdn.net/qishiai819/article/details/51394303

@interface FMDBVC ()

@property (nonatomic, strong) FMDatabase     *db;
@property (nonatomic, assign) int            mark_student;//学生标记
@property (nonatomic, strong) NSString       *docPath;//沙盒地址[数据库地址]

@end

@implementation FMDBVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"FMDB";
    [self openDB_ifNoneThen_CreateIt];
    [self toast:@"可以创建一个数据库类，用来保存用户信息，图片等"];
    
}

//打开数据库[如果没有就创建]
- (void)openDB_ifNoneThen_CreateIt
{
    //1.获取数据库文件的路径
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",_docPath);
    _mark_student = 1;
    //设置数据库名称
    NSString *fileName = [_docPath stringByAppendingPathComponent:@"student.sqlite"];
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open])
    {
        NSLog(@"打开数据库成功");
    }
    else
    {
        NSLog(@"打开数据库失败");
    }
}

#pragma mark 创建表
- (IBAction)createTable:(id)sender
{
    //3.创建表
    BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result)
    {
        NSLog(@"创建表成功");
    }
    else
    {
        NSLog(@"创建表失败");
    }
    
}

#pragma mark 增
- (IBAction)addDataToTable:(id)sender
{
    //插入数据
    NSString *name = [NSString stringWithFormat:@"kenshin%@",@(_mark_student)];
    int age = _mark_student;
    NSString *sex = @"男";
    _mark_student ++;
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [_db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
    //    BOOL result = [_db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
    //3.参数是数组的使用方式
    //    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
    if (result)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }
}

#pragma mark 删
- (IBAction)delDataInTable:(id)sender
{
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
    int idNum = 11;
    BOOL result = [_db executeUpdate:@"delete from t_student where id = ?",@(idNum)];
    //2.不确定的参数用%@，%d等来占位
    //BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
    if (result)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    
    
}

#pragma mark 改
- (IBAction)updateInTable:(id)sender
{
    //修改学生的名字
    NSString *newName = @"はんきばう";
    NSString *oldName = @"kenshin1";
    BOOL result = [_db executeUpdate:@"update t_student set name = ? where name = ?",newName,oldName];
    if (result)
    {
        NSLog(@"修改成功");
    }
    else
    {
        NSLog(@"修改失败");
    }
    
}

#pragma mark 查
- (IBAction)readDataInTable:(id)sender
{
    //查询整个表
    FMResultSet * resultSet = [_db executeQuery:@"select * from t_student"];
    //根据条件查询
    //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
    //遍历结果集合
    while ([resultSet next])
    {
        int idNum      = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumn:@"name"];
        int age        = [resultSet intForColumn:@"age"];
        NSString *sex  = [resultSet objectForColumn:@"sex"];
        NSLog(@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex);
    }
    
}

#pragma mark 删除表
- (IBAction)delTableInDB:(id)sender
{
    //如果表格存在 则销毁
    BOOL result = [_db executeUpdate:@"drop table if exists t_student"];
    if (result)
    {
        NSLog(@"删除表成功");
    }
    else
    {
        NSLog(@"删除表失败");
    }
    
    
}

#pragma mark 实际应用
- (IBAction)dbInPro:(id)sender
{
    //例如保存聊天信息、用户信息等数据
    //下面创建一个数据管理类，专门用来管理用户信息数据
    UserInfoVC *vc = [[UserInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

/*
 SQLite是嵌入式关系数据库管理系统。 它是独立的，无服务器的，零配置和事务性SQL数据库引擎。
 
 SQLite可以自由地用于商业或私有的任何目的。 换句话说，“SQLite是一种开源，零配置，独立的，独立的，旨在嵌入到应用程序中的事务关系数据库引擎”。
 
 SQLite与其他SQL数据库不同，SQLite没有单独的服务器进程。 它直接读取和写入普通磁盘文件。 具有多个表，索引，触发器和视图的完整SQL数据库包含在单个磁盘文件中。
 */
@end
