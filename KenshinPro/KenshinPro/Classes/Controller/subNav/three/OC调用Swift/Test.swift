//
//  Test.swift
//  KenshinPro
//
//  Created by kenshin on 17/4/13.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

import Foundation


class Student: NSObject
{
    //2019-3-27之前是没有使用 @objc 修饰的， 这样做的目的是为了让OC能够调用这里的成员，不然会报错
    //另外 xcode10.2 已经无法支持swift3.0的版本了，最低从swift4开始支持
    @objc var name = "我是Swift 被Objective-C 调用了";
    
    @objc func logStr(str:String)
    {
        NSLog("这是一swift 的log:%@", str)
        
        //调用了OC中的类
        let qtcom = Tools();
        
        qtcom.swiftCallObjFunc();//对象方法
        Tools.swiftCallClassFunc();//类想法
    }
    
}
