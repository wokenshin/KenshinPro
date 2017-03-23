//
//  BaseModel.h
//  LongDaUser
//
//  Created by kenshin van on 2017/3/9.
//  Copyright © 2017年 kenshin van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject


/**
 初始化方法

 @param dic 根据传入的字典初始化模型
 @return 模型实例
 */
+ (instancetype)model:(NSDictionary *)dic;

@end
