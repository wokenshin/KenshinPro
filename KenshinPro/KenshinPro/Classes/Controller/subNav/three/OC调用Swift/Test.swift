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
    var name = "我是Swift 被Objective-C 调用了";
    
    func logStr(str:String)
    {
        NSLog("这是一swift 的log:%@", str)
        
        //调用了OC中的类
        let qtcom = Tools();
        
        qtcom.swiftCallObjFunc();//对象方法
        Tools.swiftCallClassFunc();//类想法
    }
    
}
