//
//  SingleComponentPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "SingleComponentPickerVC.h"

@interface SingleComponentPickerVC ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray             *arr;

@end

@implementation SingleComponentPickerVC

//注意：xib中的 代理和数据源的拖线是要拖在 File's Owner上，否则会崩溃
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单滚轮选取器";
    _arr = @[@"王大锤",@"李二狗",@"李狗蛋",@"阿呆",@"阿瓜"];
    
}


- (IBAction)clickBtn:(id)sender {
    
    //获取选取器当前选择
    //需要指定想要询问的是第几个滚轮，一个picker可以有多个滚轮，这里的0是指第一个滚轮
    NSInteger row = [_pickerView selectedRowInComponent:0];
    
    
    NSString *selected = _arr[row];
    NSString *title = [NSString stringWithFormat:@"You selected %@!", selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@"Thank you for choosing!"
                                                   delegate:nil
                                          cancelButtonTitle:@"You're welcome"
                                          otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//滚轮数量
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_arr count];//指定滚轮应该有多少行数据
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _arr[row];
}

@end
