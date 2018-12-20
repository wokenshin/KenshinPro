//
//  XibTwoVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "XibTwoVC.h"

@interface XibTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UILabel *labSlider;
@property (weak, nonatomic) IBOutlet UISwitch *switchLeft;
@property (weak, nonatomic) IBOutlet UISwitch *switchRight;

@end

@implementation XibTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

//当在键盘中点击 return 时 会触发
- (IBAction)returnAction:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)clickBackground:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)dragSliderAction:(UISlider *)sender {
//    NSInteger value = sender.value;
    long progress =  lroundf(sender.value);
    _labSlider.text = [NSString stringWithFormat:@"%ld", progress];
}
- (IBAction)switchChangeAction:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    [_switchLeft setOn:setting];
    [_switchRight setOn:setting];
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
}

@end
