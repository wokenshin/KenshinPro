//
//  ClassOne.h
//  KenshinPro
//
//  Created by apple on 2019/2/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ClassTwo;
@interface ClassOne : NSObject

@property (nonatomic, strong) ClassTwo  *two;

- (void)funcOne;

@end

NS_ASSUME_NONNULL_END
