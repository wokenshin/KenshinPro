//
//  NSObject+Runtime.h
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

// @property分类:只会生成get,set方法声明,不会生成实现,也不会生成下划线成员属性
@property NSString *name;
@property NSString *height;





/**
 字典转模型 简单实现

 @param dict 字典
 @return 模型
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict;

/**
 字典转模型 模型中嵌套模型

 @param dict 字典
 @return 模型
 */
+ (instancetype)modelWithDict2:(NSDictionary *)dict;

@end
