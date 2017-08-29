//
//  FXW_TextDatePicker.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_TextDatePicker.h"
#import "DateUtil.h"

@interface FXW_TextDatePicker()<UITextFieldDelegate>

@property (nonatomic, strong) UIDatePicker                  *picker;
@property (nonatomic, assign) BOOL                          isInitValue;

@end

@implementation FXW_TextDatePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
        
    }
    return self;
}

- (void)setUp
{
    _picker = [[UIDatePicker alloc] init];
    _picker.locale   = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];
    _picker.timeZone = [NSTimeZone systemTimeZone];
    _picker.datePickerMode  = UIDatePickerModeDateAndTime;//日期格式
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.date = [NSDate date];
    [_picker addTarget:self action:@selector(fxw_valueChange) forControlEvents:UIControlEventValueChanged];
    
    _picker.minimumDate = [NSDate date];//设置从当前开始  之前的时间不可选择
    
    self.inputView = _picker;
    self.delegate  = self;///实现代理 禁止编辑
}

#pragma mark 代理
//禁止用户输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSLog(@"我顶你个肺啊！");
    return NO;
    
}

//开始编辑时调用[第一次获取焦点时调用]
- (void)textFieldDidBeginEditing:(FXW_TextDatePicker *)textField
{
    //这段代码只会执行一遍
    if (!_isInitValue)
    {
        [self initTextValue];
        _isInitValue = YES;
    }
}

- (void)initTextValue
{
    [self fxw_valueChange];
}


- (void)fxw_valueChange
{
    //将选择器的时间 已文本格式 赋值给文本框
    NSString *dateStr = [self dateToString:self.picker.date];
    self.text = [NSString stringWithFormat:@"%@:00:00", dateStr];
    
    //将字符串日期 转成 long
    long time1 = [DateUtil stringToTimespan:self.text dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    long time2 = [DateUtil stringToTimespan:dateStr   dateFormat:@"yyyy-MM-dd HH"];
    long time3 = [self.picker.date timeIntervalSince1970];
    
    
    NSString *str1 = [DateUtil longToString:time1];
    NSString *str2 = [DateUtil longToString:time2];
    NSString *str3 = [DateUtil longToString:time3];
    
    str1 = nil;
    str2 = nil;
    str3 = nil;
    //NSString *cuTime = [self getCuTimeStr];
    
    _recodeSelectedTime = time3;//[cuTime integerValue];//time3;
    NSLog(@"");


}

- (NSString *)getCuTimeStr
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString *cuTimestamp   = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:interval]];
    NSInteger time = [cuTimestamp integerValue];
    cuTimestamp = [NSString stringWithFormat:@"%ld", (long)time];
    return cuTimestamp;
    
}

//将date转成 时间字符串
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH";// HH:mm"; // 设置时间和日期的格式yyyy-MM-dd HH:mm:ss
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}


@end
