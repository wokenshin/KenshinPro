//
//  XibTwoVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "XibTwoVC.h"

@interface XibTwoVC ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UILabel *labSlider;
@property (weak, nonatomic) IBOutlet UISwitch *switchLeft;
@property (weak, nonatomic) IBOutlet UISwitch *switchRight;
@property (weak, nonatomic) IBOutlet UIButton *btn;

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
    if (sender.selectedSegmentIndex == 0) {
        _switchLeft.hidden = NO;
        _switchRight.hidden = NO;
        _btn.hidden = YES;
    }
    else{
        _switchLeft.hidden = YES;
        _switchRight.hidden = YES;
        _btn.hidden = NO;
    }
}


- (IBAction)clickBtn:(id)sender {
    
    //应该使用 UIAlertController
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?"
                                                        delegate:self
                                               cancelButtonTitle:@"No way!"
                                          destructiveButtonTitle:@"Yes I'm sure!"
                                               otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark 表单 代理
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSString *msg = nil;
        if (_txtName.text.length > 0) {
            msg = [NSString stringWithFormat:@"You can breathe easy, %@, everything went OK.", _txtName.text];
        }
        else{
            msg = @"You can breathe easy, everything went OK.";
        }
        
        //UIAlertController 推荐
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something was done"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"Phew!"//表示厌恶、不安、松一口气等）唷！呸！哎呀！
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
