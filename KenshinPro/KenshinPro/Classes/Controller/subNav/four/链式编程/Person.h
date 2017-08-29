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

@end
