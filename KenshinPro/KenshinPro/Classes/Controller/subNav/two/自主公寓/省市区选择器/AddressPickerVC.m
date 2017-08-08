//
//  AddressPickerVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/1.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AddressPickerVC.h"
#import "addressModel.h"
#import "TextPickerVC.h"

@interface AddressPickerVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray          *shengArray;
    NSMutableArray          *shiArray;
    NSMutableArray          *xianArray;
    
    UIPickerView            *myPickerView;
    NSMutableDictionary     *chooseDic;
    
    NSString                *sheng;
    NSString                *shi;
    NSString                *qu;
}

@property (weak, nonatomic) IBOutlet UILabel *labTips;

@end

@implementation AddressPickerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAddressPickerUI];
    
}

- (void)initAddressPickerUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"省市区-选择器";
    [self initMyPicker];
    
}

- (void)initMyPicker
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"]];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *dataArray=dataDic[@"result"][0][@"son"];
    //    NSLog(@"%@",dataArray);
    
    shengArray = [NSMutableArray array];
    shiArray   = [NSMutableArray array];
    xianArray  = [NSMutableArray array];
    
    chooseDic  = [NSMutableDictionary dictionary];
    
    sheng   = @"";
    shi     = @"";
    qu      = @"";
    
    //省数组
    shengArray = [addressModel mj_objectArrayWithKeyValuesArray:dataArray];
    //市数组，默认省数组第一个
    addressModel *model = shengArray[0];
    shiArray = [addressModel mj_objectArrayWithKeyValuesArray:model.son];
    
    //县数组，默认市数组第一个
    addressModel *model1=shiArray[0];
    xianArray=[addressModel mj_objectArrayWithKeyValuesArray:model1.son];
    addressModel *model2=xianArray[0];
    
    [chooseDic setValue:model.area_id  forKey:@"sheng"];
    [chooseDic setValue:model.area_id  forKey:@"shi"];
    [chooseDic setValue:model2.area_id forKey:@"xian"];
    
    
    // 选择框
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 300)];
    // 显示选中框
    myPickerView.showsSelectionIndicator=YES;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [self.view addSubview:myPickerView];
    
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return shengArray.count;
    }
    if (component==1) {
        return  shiArray.count;
    }
    if (component==2) {
        return xianArray.count;
    }
    
    return 0;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"选中%ld列---%ld行",(long)component,(long)row);
    if (component==0)
    {
        addressModel *model = shengArray[row];
        shiArray = [addressModel mj_objectArrayWithKeyValuesArray:model.son];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        
        //默认第一个
        addressModel *model1 = shiArray[0];
        xianArray = [addressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        addressModel *model2 = xianArray[0];
        [chooseDic setValue:model.area_id  forKey:@"sheng"];
        [chooseDic setValue:model1.area_id forKey:@"shi"];
        [chooseDic setValue:model2.area_id forKey:@"xian"];
    }
    if (component==1)
    {
        addressModel *model1 = shiArray[row];
        xianArray = [addressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        addressModel *model2 = xianArray[0];
        [chooseDic setValue:model1.area_id forKey:@"shi"];
        [chooseDic setValue:model2.area_id forKey:@"xian"];
    }
    if (component==2)
    {
        addressModel *model2 = xianArray[row];
        [chooseDic setValue:model2.area_id forKey:@"xian"];
    }
    NSLog(@"%@",chooseDic);
    
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        addressModel *model = shengArray[row];
        sheng = model.area_district;
        _labTips.text = [NSString stringWithFormat:@"%@·%@·%@", sheng, shi, qu];
        return model.area_district;
    }
    if (component==1)
    {
        addressModel *model = shiArray[row];
        shi = model.area_district;
        _labTips.text = [NSString stringWithFormat:@"%@·%@·%@", sheng, shi, qu];
        return model.area_district;
    }
    if (component==2)
    {
        addressModel *model = xianArray[row];
        qu = model.area_district;
        _labTips.text = [NSString stringWithFormat:@"%@·%@·%@", sheng, shi, qu];
        return model.area_district;
    }
    return nil;
}


- (IBAction)clickBtn:(id)sender
{
    TextPickerVC *vc = [[TextPickerVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
