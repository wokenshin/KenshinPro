//
//  Person.h
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject


- (void)run;
- (void)learn;

- (Person *)run1;
- (Person *)learn1;

- (Person* (^)())runBlock;
- (Person* (^)())learnBlock;

//2017_11_08
//这里有两个私有方法 用于 runtime的 demo中
//- (void)fxw_eat;
//- (void)fxw_run:(NSString *)str;

//2017_11_10
+ (void)classFunction;
- (void)instanceFunction;

@end
