//
//  OCAndVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/13.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OCAndVC.h"
#import "KenshinPro-Swift.h"

/**
 参考 http://www.jianshu.com/p/01410d991788
 
 混编的时候 需要注意以下几点：
 1、配置BuildSetting->搜索 pack  找到  Defines Modul 设置为 YES 再找到 Product Name 设置为 工程名字，如果是工程名字就不用管了
 2、创建Swift文件，第一次创建Swift文件时，会提示是否创建桥接头文件，该文件是为了在Swift中调用OC而创建的，点击创建。
    注意：如果这里没有创建，或者中间删除了该文件。下次再创建Swift文件的时候，就不会提示创建该文件了，此时需要手动创建。
    特别注意创建该文件时的文件命名格式：工程名-Bridging-Header.h
    检查是否生成了桥接头文件路径：第一次自动生成该文件的时候也要做此检查【我的环境是Xcode8 这里已经自动生成了】
 3、检查路径：BuildSetting->搜索 objective-c br 查看是否有桥接文件的路径，如果没有就添加上去，参考如下:
    KenshinPro/Classes/Controller/subNav/three/OC调用Swift/KenshinPro-Bridging-Header.h
 
 */
@interface OCAndVC ()

@end

@implementation OCAndVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"OC下调用Swift";
    
}

//OC调用自己创建的Swift
- (IBAction)clickOCCallSwiftBase:(id)sender
{
    Student * s1 = [[Student alloc] init];
    NSLog(@"%@", s1.name);
    
}

//Swift 调用 OC  其实这里为了方便 是直接用OC调用了Swift中的方法 而这个方法调用了OC
- (IBAction)clickSwiftCallOc:(id)sender
{
    Student * s1 = [[Student alloc] init];
    [s1 logStrWithStr:@"其实这里为了方便 是直接用OC调用了Swift中的方法 而这个方法调用了OC"];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
