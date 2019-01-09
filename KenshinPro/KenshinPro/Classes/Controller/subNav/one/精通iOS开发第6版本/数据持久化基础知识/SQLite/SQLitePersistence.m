//
//  SQLitePersistence.m
//  KenshinPro
//
//  Created by apple on 2019/1/9.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "SQLitePersistence.h"
#import <sqlite3.h>

@interface SQLitePersistence ()

@property (nonatomic, strong) IBOutletCollection(UITextField)  NSArray   *lineFields;

@end

@implementation SQLitePersistence

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sqlite3 *db;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Failed to open database");
    }
    
    //有用的C语言小知识
    //如果两个内联的字符串之间只有空白(包括换行符)而没有其他字符
    //那么这两个字符串会被连接为一个字符串
    NSString *createSQL = @"create table if not exists fields"
    "(row integer primary key, field_data text);";
    char *errorMsg;
    
    if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Error creating table:%s", errorMsg);
    }
    
    NSString *query = @"select row, field_data from fields order by row";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
            char *rowData = (char*)sqlite3_column_text(statement, 1);
            
            NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
            UITextField *field = self.lineFields[row];
            field.text = fieldValue;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(db);
    
    //接收通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
                                               object:app];
}

- (void)applicationWillResignActive:(NSNotification *)notify{
    
    sqlite3 *db;
    if (sqlite3_open([[self dataFilePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Failed to open database");
    }
    
    for (int i = 0; i < 4; i++) {
        UITextField *filed = self.lineFields[i];
        //内联字符串的连接 又一次派上用场了
        char *update = "insert or replace into fields (row, field_data)"
        "values(?, ?);";
        char *errorMsg = NULL;
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(db, update, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt, 1, i);
            sqlite3_bind_text(stmt, 2, [filed.text UTF8String], -1, NULL);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table:%s", errorMsg);
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(db);
    
}

- (NSString *)dataFilePath{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [arr firstObject];
    return [docPath stringByAppendingPathComponent:@"data.sqlite"];
}

@end
