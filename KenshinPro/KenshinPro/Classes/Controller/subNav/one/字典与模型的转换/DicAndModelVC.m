//
//  DicAndModel.m
//  KenshinPro
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DicAndModelVC.h"
#import "MJExtension.h"
#import "User.h"
#import "MJStatusResult.h"
#import "MJStatus.h"
#import "MJAd.h"
#import "MJStudent.h"
#import "MJBag.h"

//更多内容请到gitHub下载 MJExtension
@interface DicAndModelVC ()

@end

@implementation DicAndModelVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"字典与模型的转换";
}

//简单的字典转模型
- (IBAction)clickBaseDicToModel:(id)sender
{
    // 1.定义一个字典[字典中可以不完全包含模型的类型，也可以超出模型的定义]
    NSDictionary *dict = @{
                           @"name" : @"Jack",
//                           @"icon" : @"lufy.png",//如果注释掉某一个类型，解析模型出来的后没有的值为类型默认值
                           @"age" : @"20",
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"dream":@"happy",//多出来的类型
                           @"gay" : @"1"//这里的BOOL 随便用那种都可以
//                             @"gay" : @"NO"
//                             @"gay" : @"true"
                           };
    
    // 2.将字典转为User模型
    User *user = [User mj_objectWithKeyValues:dict];
    if (user.icon == nil)
    {
        NSLog(@"icon == nil");
    }
    if ([user.icon isEqual:[NSNull null]])
    {
        NSLog(@"icon == null");
    }
    
    // 3.打印User模型的属性
    MJExtensionLog(@"name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
    
}

//JSON字符串 -> 模型
- (IBAction)JsonToModel:(id)sender
{
    // 1.定义一个JSON字符串[注意 这里的json没有完全包含User中的数据，没有的转换后为类型默认值]
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20, \"height\":333333.7}";
    
    // 2.将JSON字符串转为User模型
    User *user = [User mj_objectWithKeyValues:jsonString];
    
    // 3.打印User模型的属性
    MJExtensionLog(@"name=%@, icon=%@, age=%d, height=%@", user.name, user.icon, user.age, user.height);
    
}

//复杂的字典 -> 模型 (模型的数组属性里面又装着模型)
- (IBAction)dicToModelArr:(id)sender
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    // 2.将字典转为MJStatusResult模型
    MJStatusResult *result = [MJStatusResult mj_objectWithKeyValues:dict];
    
    // 3.打印MJStatusResult模型的简单属性
    MJExtensionLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    for (MJStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        MJExtensionLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (MJAd *ad in result.ads) {
        MJExtensionLog(@"image=%@, url=%@", ad.image, ad.url);
    }

    
}

//模型->字典
- (IBAction)modelToDic:(id)sender
{
    // 1.新建模型
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    
    MJStatus *status = [[MJStatus alloc] init];
    status.user = user;
    status.text = @"今天的心情不错！";
    
    // 2.将模型转为字典
    NSDictionary *statusDict = status.mj_keyValues;
    MJExtensionLog(@"%@", statusDict);
    
    MJExtensionLog(@"%@", [status mj_keyValuesWithKeys:@[@"text"]]);
    
    // 3.新建多级映射的模型
    MJStudent *stu = [[MJStudent alloc] init];
    stu.ID = @"123";
    stu.oldName = @"rose";
    stu.nowName = @"jack";
    stu.desc = @"handsome";
    stu.nameChangedTime = @"2018-09-08";
    stu.books = @[@"Good book", @"Red book"];
    
    MJBag *bag = [[MJBag alloc] init];
    bag.name = @"小书包";
    bag.price = 205;
    stu.bag = bag;
    
    NSDictionary *stuDict = stu.mj_keyValues;
    MJExtensionLog(@"%@", stuDict);
    MJExtensionLog(@"%@", [stu mj_keyValuesWithIgnoredKeys:@[@"bag", @"oldName", @"nowName"]]);
    MJExtensionLog(@"%@", stu.mj_JSONString);
    
    [MJStudent mj_referenceReplacedKeyWhenCreatingKeyValues:NO];
    MJExtensionLog(@"\n模型转字典时，字典的key参考replacedKeyFromPropertyName等方法:\n%@", stu.mj_keyValues);

    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
