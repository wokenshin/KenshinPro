//
//  FXW_TextAddress.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/1.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_TextAddress.h"
#import "addressModel.h"
#import "MJExtension.h"

@interface FXW_TextAddress()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

//数据源
@property (nonatomic, strong) NSMutableArray                *shengArray;
@property (nonatomic, strong) NSMutableArray                *shiArray;
@property (nonatomic, strong) NSMutableArray                *xianArray;
//@property (nonatomic, strong) NSMutableDictionary           *chooseDic;//选中后的数据

//选择后的 省市区
@property (nonatomic, strong) NSString                      *sheng;
@property (nonatomic, strong) NSString                      *shi;
@property (nonatomic, strong) NSString                      *qu;

@property (nonatomic, strong) UIPickerView                  *myPickerView;


@end

@implementation FXW_TextAddress

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

//初始化
- (void)setUp
{
    //获取数据
    [self loadData];
    
    //自定义城市键盘
    self.myPickerView = [[UIPickerView alloc] init];
    self.myPickerView.delegate   = self;
    self.myPickerView.dataSource = self;
    
    //设置Field的弹出键盘为 myPickerView
    self.inputView = self.myPickerView;
    
    self.delegate  = self;///实现代理 禁止编辑
    
    
}

- (void)loadData
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"]];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *dataArray=dataDic[@"result"][0][@"son"];
    //    NSLog(@"%@",dataArray);
    
    _shengArray = [NSMutableArray array];
    _shiArray   = [NSMutableArray array];
    _xianArray  = [NSMutableArray array];
    
//    _chooseDic  = [NSMutableDictionary dictionary];
    
    _sheng      = @"";
    _shi        = @"";
    _qu         = @"";
    
    //省数组
    _shengArray = [addressModel mj_objectArrayWithKeyValuesArray:dataArray];
    //市数组，默认省数组第一个
    addressModel *model = _shengArray[0];
    _shiArray   = [addressModel mj_objectArrayWithKeyValuesArray:model.son];
    
    //县数组，默认市数组第一个
    addressModel *model1 = _shiArray[0];
    _xianArray  = [addressModel mj_objectArrayWithKeyValuesArray:model1.son];
    addressModel *model2 = _xianArray[0];
    
//    [_chooseDic setValue:model.area_id  forKey:@"sheng"];
//    [_chooseDic setValue:model.area_id  forKey:@"shi"];
//    [_chooseDic setValue:model2.area_id forKey:@"xian"];
    
}

//初始化文本框的默认值［在第一次获取到焦点的时候调用］
- (void)initTextValue
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [self pickerView:self.myPickerView didSelectRow:0 inComponent:0];
        
    });
    
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _shengArray.count;
    }
    if (component==1)
    {
        return  _shiArray.count;
    }
    if (component==2)
    {
        return _xianArray.count;
    }
    
    return 0;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"选中%ld列---%ld行",(long)component,(long)row);
    if (component==0)
    {
        addressModel *model = _shengArray[row];
        _shiArray = [addressModel mj_objectArrayWithKeyValuesArray:model.son];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        
        //默认第一个
        addressModel *model1 = _shiArray[0];
        _xianArray = [addressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        addressModel *model2 = _xianArray[0];
//        [_chooseDic setValue:model.area_id  forKey:@"sheng"];
//        [_chooseDic setValue:model1.area_id forKey:@"shi"];
//        [_chooseDic setValue:model2.area_id forKey:@"xian"];
        
        _sheng = model.area_district;
        _shi = model1.area_district;
        _qu = model2.area_district;
        
    }
    if (component==1)
    {
        addressModel *model1 = _shiArray[row];
        _xianArray = [addressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        addressModel *model2 = _xianArray[0];
//        [_chooseDic setValue:model1.area_id forKey:@"shi"];
//        [_chooseDic setValue:model2.area_id forKey:@"xian"];
        
        _shi = model1.area_district;
        _qu = model2.area_district;
    }
    if (component==2)
    {
        addressModel *model2 = _xianArray[row];
//        [_chooseDic setValue:model2.area_id forKey:@"xian"];
        
        _qu = model2.area_district;
    }
//    NSLog(@"%@",_chooseDic);
    
    //给文本框赋值
    self.text = [NSString stringWithFormat:@"%@·%@·%@", _sheng, _shi, _qu];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        addressModel *model = _shengArray[row];
        _sheng = model.area_district;
        return model.area_district;
    }
    if (component==1)
    {
        addressModel *model = _shiArray[row];
        _shi = model.area_district;
        return model.area_district;
    }
    if (component==2)
    {
        addressModel *model = _xianArray[row];
        _qu = model.area_district;
        return model.area_district;
    }
    return nil;
    
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
- (void)textFieldDidBeginEditing:(FXW_TextAddress *)textField
{
    [self initTextValue];
    
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

@end
