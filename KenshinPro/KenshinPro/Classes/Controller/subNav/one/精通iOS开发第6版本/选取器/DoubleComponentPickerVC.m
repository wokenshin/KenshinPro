//
//  DoubleComponentPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "DoubleComponentPickerVC.h"

@interface DoubleComponentPickerVC ()

<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray   *arrLeft;
@property (nonatomic, strong) NSArray   *arrRight;

@end

static const int RollerLeft  = 0;//左轮
static const int RollerRight = 1;

@implementation DoubleComponentPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多轮选取器";
    
    _arrLeft  = @[@"鸟山明", @"井上雄彦", @"安达充", @"高桥留美子", @"尾田荣一郎", @"岸本齐史"];
    _arrRight = @[@"《七龙珠》", @"《灌篮高手》", @"《Touch》", @"《犬夜叉》", @"《海贼王》", @"《火影忍者》"];
    
}

- (IBAction)clickBtn:(id)sender {
    
    //获取指定滚轮当前选中的索引
    NSInteger rowL = [_pickerView selectedRowInComponent:RollerLeft];
    NSInteger rowR = [_pickerView selectedRowInComponent:RollerRight];
    
    //获取指定滚轮当前选中的值
    NSString *strL = _arrLeft[rowL];
    NSString *strR = _arrRight[rowR];
    
    NSString *msg = [NSString stringWithFormat:@"Left : %@, Right : %@", strL, strR];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for order"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"Great"
                                          otherButtonTitles:nil];
    [alert show];
    
}



#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//轮子个数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == RollerLeft) {
        return [_arrLeft count];
    } else {
        return [_arrRight count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == RollerLeft) {
        return _arrLeft[row];
    } else {
        return _arrRight[row];
    }
    
}


@end
