//
//  KenshinProTests.m
//  KenshinProTests
//
//  Created by kenshin on 17/3/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <XCTest/XCTest.h>
//注意 在Xcode10中会发现再写单元测试时导入头文件没有提示的问题：https://www.jianshu.com/p/0a0ad7e14f87
#import "FXW_Define.h"

@interface KenshinProTests : XCTestCase

@end

@implementation KenshinProTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"我嘞个去！");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
