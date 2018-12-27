//
//  DependentComponentPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "DependentComponentPickerVC.h"

@interface DependentComponentPickerVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray      *arrSchool;
@property (nonatomic, strong) NSArray      *arrCuClassMate;//当前班级的同学 这数组的值是根据前一个轮子的数据不断变化的


@end

static const int Left_School     = 0;//学校
static const int Right_Classmate = 1;//同学
@implementation DependentComponentPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容依赖";
    [self loadPickerData];
    
}

- (void)loadPickerData{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"pickerDic" withExtension:@"plist"];
    
    //获取所有数据
    _dic = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    //获取字典中全部的key【学校】 key对应的数组就是 学校的同学
    NSArray *arrAllSchool    = [_dic allKeys];
    
    //按字母顺序排序
//    NSArray *arrSortedSchool = [arrAllSchool sortedArrayUsingSelector:@selector(compare:)];
//    _arrSchool = [NSArray arrayWithArray:arrSortedSchool];
    
    //不按字母顺序排序
    _arrSchool = [NSArray arrayWithArray:arrAllSchool];
    
    NSString *nameSchool = _arrSchool[0];
    _arrCuClassMate = _dic[nameSchool];
    NSLog(@"asd");
}

- (IBAction)clickBtn:(id)sender {
    
    //获取当前选择的轮子的索引
    NSInteger rowSchool    = [_pickerView selectedRowInComponent:Left_School];
    NSInteger rowClassMate = [_pickerView selectedRowInComponent:Right_Classmate];
    
    //获取对应索引中的值
    NSString *nameSchool    = _arrSchool[rowSchool];
    NSString *nameClassMate = _arrCuClassMate[rowClassMate];
    
    NSString *title = [NSString stringWithFormat:@"学校：%@ 同学：%@", nameSchool, nameClassMate];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@"memory"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}

#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//轮子个数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == Left_School) {
        return [_arrSchool count];
    } else {
        return [_arrCuClassMate count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == Left_School) {
        return _arrSchool[row];
    } else {
        return _arrCuClassMate[row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == Left_School) {
        //获取当前选中的学校
        NSString *selectedSchool = _arrSchool[row];
        //获取选中学校对应的同学
        _arrCuClassMate = _dic[selectedSchool];
        
        //重新加载第二个轮子的数据
        [_pickerView reloadComponent:Right_Classmate];
        
        //动画效果
        [_pickerView selectRow:0 inComponent:Right_Classmate animated:YES];
    }
}

//设置 指定轮子的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    //滚轮的宽度建议应该获取屏幕宽度来设置
    if (component == Right_Classmate) {
        return screenWidth * 0.7;
    } else {
        return screenWidth * 0.3;
    }
}
@end
