//
//  UserInfo.h
//  KenshinPro
//
//  Created by kenshin van on 2017/12/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 学号
 */
@property (nonatomic, strong) NSString *number;

/**
 性别
 */
@property (nonatomic, strong) NSString *gender;

/**
 年龄
 */
@property (nonatomic, assign) int      age;;

@end
