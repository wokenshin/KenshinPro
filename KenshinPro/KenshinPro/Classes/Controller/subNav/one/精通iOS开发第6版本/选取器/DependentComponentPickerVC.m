//
//  DependentComponentPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "DependentComponentPickerVC.h"

@interface DependentComponentPickerVC ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSArray               *arr;
@property (nonatomic, strong) NSMutableDictionary   *mDic;

@end

static const int DRollerLeft  = 0;//左轮
static const int DRollerRight = 1;
@implementation DependentComponentPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容依赖";
}

- (IBAction)clickBtn:(id)sender {
    
}

#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//轮子个数
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == DRollerLeft) {
        return 0;
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == DRollerLeft) {
        return 0;
    } else {
        return 0;
    }
    
}

@end
