//
//  ModelOrderCtrling.h
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOrderCtrling : NSObject

@property (nonatomic, strong) NSString              *orderNo;

@property (nonatomic, strong) NSString              *name;

@property (nonatomic, strong) NSString              *address;


/**
 1 待结单  2 处理中   3 已完成
 */
@property (nonatomic, assign) NSInteger              orderStatus;

@end
