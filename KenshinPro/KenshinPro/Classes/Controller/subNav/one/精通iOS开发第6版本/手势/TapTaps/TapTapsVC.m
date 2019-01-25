//
//  TapTapsVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "TapTapsVC.h"

@interface TapTapsVC ()
@property (weak, nonatomic) IBOutlet UILabel *lab1;//单指
@property (weak, nonatomic) IBOutlet UILabel *lab2;//双指
@property (weak, nonatomic) IBOutlet UILabel *lab3;//三指
@property (weak, nonatomic) IBOutlet UILabel *lab4;//四指

@end

@implementation TapTapsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"避免手势冲突";
    
    //单指
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    //双指
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];//避免冲突
    
    //三指
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTap)];
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tripleTap];
    [doubleTap requireGestureRecognizerToFail:tripleTap];//避免冲突
    
    //四指
    UITapGestureRecognizer *quadrupleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quadrupleTap)];
    quadrupleTap.numberOfTapsRequired = 4;
    quadrupleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:quadrupleTap];
    [tripleTap requireGestureRecognizerToFail:quadrupleTap];//避免冲突
}

- (void)singleTap{
    _lab1.text = @"Single Tap Detected";
    [self performSelector:@selector(clearLabel:) withObject:self.lab1 afterDelay:1.6f];
}

- (void)doubleTap{
    _lab2.text = @"Double Tap Detected";
    [self performSelector:@selector(clearLabel:) withObject:self.lab2 afterDelay:1.6f];
}

- (void)tripleTap{
    _lab3.text = @"tripleTap Tap Detected";
    [self performSelector:@selector(clearLabel:) withObject:self.lab3 afterDelay:1.6f];
}

- (void)quadrupleTap{
    _lab4.text = @"quadrupleTap Tap Detected";
    [self performSelector:@selector(clearLabel:) withObject:self.lab4 afterDelay:1.6f];
}

- (void)clearLabel:(UILabel *)lab{
    lab.text = @"";
}
@end
