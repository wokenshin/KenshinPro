//
//  BundleVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "BundleVC.h"

/**
 1.创建的是 TARGETS 下的 bundle文件 命名为 TestBundle 并做了相关配置
 2.向TestBundle文件中添加需要的文件 可以添加图片，xib等
 3.选择工程->TestBundle-?Generic iOS Device 编译->在Products中找到 TestBundle 查看Finder可以找到真机下的bundle文件
 4.将真机下的bundle文件拷贝出来拿到工程中使用
 */
@interface BundleVC ()

@end

@implementation BundleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Bundle";
    
    UIImage *image = [UIImage imageNamed:@"TestBundle.bundle/heart.jpg"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imgView.image = image;
    [self.view addSubview:imgView];
    
    

}


@end
