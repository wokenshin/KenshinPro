//
//  ClearCachesVC.m
//  GYBase
//
//  Created by doit on 16/6/15.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    参考：http://www.jianshu.com/p/739550c3caae
 
    ios 推荐 将缓存保存到 沙盒的 Caches 文件夹下，所以我们在开发的时候缓存最好保存在这个路径下。要清除缓存的时候只需要将该路径下的文件全部删除即可。
    如果你自己保存的缓存不是存放在该路径下 那么清除缓存的时候就删除指定路径下的内容即可。（最好不要这样，不规范）
 
 */

#import "ClearCachesVC.h"


@interface ClearCachesVC ()//这里处理的缓存 是针对 存储在 Caches文件下的文件

@property (nonatomic, strong)UILabel            *labCaches;//显示当前缓存大小

@property (nonatomic, strong)FXW_Button         *btnClear;//清空缓存

@end

@implementation ClearCachesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initClearCachesUI];
    [self cachesSize];
    
}

- (void)initClearCachesUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"清除缓存";
    
    CGFloat labWidth = 300;
    CGFloat btnWidth = 120;
    
    _labCaches = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - labWidth/2, 64 + 10, labWidth, 44)];
    _labCaches.textAlignment = NSTextAlignmentCenter;
    _labCaches.backgroundColor = RGB2Color(79, 190, 91);
    
    WS(ws);//防止循环引用
    _btnClear = [[FXW_Button alloc] initWithFrame:CGRectMake(screenWidth/2 - btnWidth/2, 64 + btnWidth, btnWidth, 44)];
    _btnClear.backgroundColor = [UIColor orangeColor];
    [_btnClear setTitle:@"清除缓存" forState:UIControlStateNormal];
    [_btnClear clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws clearCaches];
    }];

    
    [self.view addSubview:_labCaches];
    [self.view addSubview:_btnClear];
    
    
}

#pragma mark 计算缓存大小 并显示在lab上
- (void)cachesSize
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float folderSize;
    if ([fileManager fileExistsAtPath:path])
    {
        //拿到有文件的数组
        NSArray *childFile = [fileManager subpathsAtPath:path];
        
        //拿到每个文件的名字，如果有不想清除的文件 就在这判断[如 头像等]
        for (NSString *fileName in childFile)
        {
            NSLog(@"%@", fileName);
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizePath:fullPath];
            
        }
    }
    
    folderSize = round(folderSize*100)/100;//返回folderSize的保留小数点后两位的 四舍五入后的结果
    NSString *cachesSize = [NSString stringWithFormat:@"%.2f", folderSize];//保留小数点后两位 没有四舍五入

    cachesSize = [NSString stringWithFormat:@"当前缓存为：%@M", cachesSize];
    _labCaches.text = cachesSize;
    
}

//计算文件的大小
- (float)fileSizePath:(NSString*)path
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
        
    }
    return 0;
    
}

#pragma mark 清除缓存
- (void)clearCaches
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles)
        {
            //如果有需要 加入体检 过滤掉不删除的文件[如 头像等]
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        
    }
    
    [self cachesSize];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _labCaches = nil;
    _btnClear  = nil;
    
}

@end
