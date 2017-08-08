//
//  FXW_TextGender.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/3.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_TextPikerOne.h"
#import "Tools.h"

@interface FXW_TextPikerOne()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong)UIPickerView                   *cityPicker;
@property (nonatomic, strong) NSArray                       *arrData;
@property (nonatomic, assign) BOOL                          isInitValue;

@end

@implementation FXW_TextPikerOne

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

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data
{
    if (self = [super initWithFrame:frame])
    {
        _arrData = [NSArray arrayWithArray:data];
        [self setUp];
        
    }
    return self;
}

//初始化
- (void)setUp
{
    if (_arrData == nil)
    {
        _arrData = @[@"默认选项",@"请用纯代码实现",@"或者重写awakeFromNib"];
    }
    
    //自定义键盘
    self.cityPicker = [[UIPickerView alloc] init];
    self.cityPicker.delegate   = self;
    self.cityPicker.dataSource = self;
    
    //设置Field的弹出键盘为 cityPicker
    self.inputView = self.cityPicker;
    
    self.delegate  = self;///实现代理 禁止编辑
    
}

//初始化文本框的默认值［在第一次获取到焦点的时候调用］
- (void)initTextValue
{
    [self pickerView:self.cityPicker didSelectRow:0 inComponent:0];
    
}

#pragma mark - 数据源代理
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

//返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrData count];
    
}

//定义每一列每一行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.arrData[row];
    return title;
    
}

#pragma mark 代理 选中时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //将选中的值赋值到文本框上
    NSString *title = self.arrData[row];
    self.text = title;
    
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
- (void)textFieldDidBeginEditing:(FXW_TextPikerOne *)textField
{
    //这段代码只会执行一遍
    if (!_isInitValue)
    {
        [self initTextValue];
        _isInitValue = YES;
    }
    
}

#pragma mark 覆盖父类方法［缩进的效果］
//控制文本所在的的位置，左右缩 10[初始化 set上值的时候]
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

//控制编辑文本时所在的位置，左右缩 10[编辑的时候]
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.arrData  = nil;
    self.cityPicker = nil;
    
}

@end
