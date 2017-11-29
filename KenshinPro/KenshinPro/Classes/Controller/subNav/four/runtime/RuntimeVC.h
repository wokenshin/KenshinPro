//
//  RuntimeVC.h
//  KenshinPro
//
//  Created by kenshin on 2017/11/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

@interface RuntimeVC : BaseVC

//用于 runtime 获取
@property (nonatomic, strong) NSString                                      *haha;
@property (nonatomic, strong) NSString                                      *hehe;
@property (nonatomic, strong) NSString                                      *heihei;

//用于 runtime 获取
- (void)test1;//实现
- (void)test2:(NSString *)str;//未实现
- (NSString *)test3;//未实现

@end
