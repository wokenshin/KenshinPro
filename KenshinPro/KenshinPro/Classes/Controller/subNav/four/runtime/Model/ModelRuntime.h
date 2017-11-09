//
//  ModelRuntime.h
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubModelRuntime.h"

@interface ModelRuntime : NSObject


/**
 姓名
 */
@property (nonatomic, strong) NSString                  *name;

/**
 性别
 */
@property (nonatomic, strong) NSString                  *gender;

/**
 喜欢啥
 */
@property (nonatomic, strong) NSString                  *like;


/**
 子模型
 */
@property (nonatomic, strong) SubModelRuntime           *wife;

@end
