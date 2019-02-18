//
//  ClassTwo.h
//  KenshinPro
//
//  Created by apple on 2019/2/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ClassOne;
@interface ClassTwo : NSObject

@property (nonatomic, strong) ClassOne  *one;

- (void)functionTwo;

@end

NS_ASSUME_NONNULL_END
