//
//  CodingRuntime.h
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

//用于归档 解档
@interface CodingRuntime : NSObject<NSCoding>

@property (nonatomic, strong) NSString                                      *country;
@property (nonatomic, strong) NSString                                      *name;
@property (nonatomic, strong) NSString                                      *gender;
@property (nonatomic, assign) int                                           age;

@end
