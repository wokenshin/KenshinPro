//
//  ModelJJSJ.h
//  KenshinPro
//
//  Created by kenshin van on 2018/2/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelJJSJ : NSObject

// 是否是展开的
@property (nonatomic, assign) BOOL isExpanded;

//分组名
@property (nonatomic, strong) NSString  *sectioonName;

//分区内的数组模型
@property (nonatomic, strong) NSMutableArray *models;



@end
