//
//  CheckPleaseVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "CheckPleaseVC.h"
#import "CheckMarkRecognizer.h"

@interface CheckPleaseVC ()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation CheckPleaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用手指划勾勾识别";
    
    //手势
    CheckMarkRecognizer *check = [[CheckMarkRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(doCheck:)];
    [self.view addGestureRecognizer:check];
}

- (void)doCheck:(CheckMarkRecognizer *)check{
    _lab.text = @"CheckMark";
    [self performSelector:@selector(eraseLabel) withObject:nil afterDelay:1.6];
}

- (void)eraseLabel{
    _lab.text = @"";
}

@end
