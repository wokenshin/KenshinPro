//
//  ModelOrderWaitting.h
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOrderWaitting : NSObject

/**
 发单时间
 */
@property (nonatomic, strong) NSString          *date;

/**
 发单人姓名
 */
@property (nonatomic, strong) NSString          *name;

/**
 地址
 */
@property (nonatomic, strong) NSString          *address;

/**
 维修内容
 */
@property (nonatomic, strong) NSString          *fixContent;

@end
