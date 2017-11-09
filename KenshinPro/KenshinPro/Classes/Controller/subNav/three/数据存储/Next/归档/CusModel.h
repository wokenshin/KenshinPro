//
//  CusModel.h
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CusModel : NSObject<NSCoding>// 被归档的自定义对象 需要遵守 NSCoding 协议 并实现其中的两个方法


@property (nonatomic, strong) NSString                                      *name;
@property (nonatomic, assign) int                                           age;
@property (nonatomic, assign) float                                         height;

@end
