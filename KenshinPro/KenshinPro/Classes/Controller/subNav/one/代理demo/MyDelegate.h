//
//  MyDelegate.h
//  KenshinPro
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

//【第一步】 定义协议
@protocol CustomNameDelegate<NSObject>

//在定义的协议里可以定义 必须实现的协议 @require 和 可选实现的协议 @option

@required
- (void)myDelegateRequired;


@optional
- (void)myDelegateOptional;


@end;


@interface MyDelegate : NSObject

//【第二步】定义属性
@property (nonatomic, weak) id<CustomNameDelegate> delegate;


/**
 在执行此方法的时候就会 出发代理
 */
- (void)doSomething;

@end
