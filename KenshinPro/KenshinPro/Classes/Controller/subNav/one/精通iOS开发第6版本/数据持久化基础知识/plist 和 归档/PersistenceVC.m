//
//  PersistenceVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "PersistenceVC.h"
#import "FourLines.h"

static NSString * const kRootKey = @"kRootKey";
@interface PersistenceVC ()
@property (nonatomic, strong) IBOutletCollection(UITextField)  NSArray   *lineFields;
@end

@implementation PersistenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self loadDataByPlist];//通过 plist加载数据
    [self loadDataByArchive];//通过归档接档 加载数据
    //接收通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
                                               object:app];
    
}

- (void)loadDataByPlist{
    NSString *filePath = [self dataFilePath_plist];
    //判断文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //用文件内容 实例化数组
        NSArray *arr = [[NSArray alloc] initWithContentsOfFile:filePath];
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = arr[i];
        }
    }
}

- (void)loadDataByArchive{
    NSString *filePath = [self dataFilePath_archive];
    //判断文件是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        FourLines *fourLines = [unarchiver decodeObjectForKey:kRootKey];
        [unarchiver finishDecoding];
        
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = fourLines.lines[i];
        }
    }
}

- (void)applicationWillResignActive:(NSNotification *)notify{
    
    //[self savePlist];//保存到plist
    [self saveArchive];//归档保存
}

- (void)savePlist{
    NSString *filePath = [self dataFilePath_plist];
    
    //通过调用lineFilds数组中每一个文本框的 text 方法 构建一个字符串数组
    NSArray *arr = [self.lineFields valueForKey:@"text"];
    
    //将数组内容写入到属性列表
    [arr writeToFile:filePath atomically:YES];
}

- (void)saveArchive{
    NSString *filePath = [self dataFilePath_archive];
    FourLines *fourLines = [[FourLines alloc] init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archive encodeObject:fourLines forKey:kRootKey];
    [archive finishEncoding];
    [data writeToFile:filePath atomically:YES];

}

//属性列表路径
- (NSString *)dataFilePath_plist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *pathFile = [documentDirectory stringByAppendingPathComponent:@"data.plist"];
    return pathFile;
}

//归档接档路径
- (NSString *)dataFilePath_archive{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *pathFile = [documentDirectory stringByAppendingPathComponent:@"data.archive"];
    return pathFile;
}

@end
