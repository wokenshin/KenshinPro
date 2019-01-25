//
//  QuartzFunVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "QuartzFunVC.h"
#import "BIDConstants.h"
#import "QuartzFunView.h"

@interface QuartzFunVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorCtrl;
@property (nonatomic, strong) QuartzFunView *funView;
@end

@implementation QuartzFunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘图";
    _funView = [[QuartzFunView alloc] initWithFrame:CGRectMake(0, 120, screenWidth, screenHeight - 120 - 49)];
    [self.view addSubview:_funView];
    
}

- (IBAction)changeColor:(UISegmentedControl *)segmentCtrl {
    ColorTabIndex index = [segmentCtrl selectedSegmentIndex];
    switch (index) {
        case kRedColorTab:
        {
            _funView.currentColor = [UIColor redColor];
            _funView.useRandomColor = NO;
        }
            break;
        case kBlueColorTab:
        {
            _funView.currentColor = [UIColor blueColor];
            _funView.useRandomColor = NO;
        }
            break;
        case kYellowColorTab:
        {
            _funView.currentColor = [UIColor yellowColor];
            _funView.useRandomColor = NO;
        }
            break;
        case kGreenColorTab:
        {
            _funView.currentColor = [UIColor greenColor];
            _funView.useRandomColor = NO;
        }
            break;
        case kRandomColorTab:
        {
            _funView.useRandomColor = YES;
        }
            break;
        default:
            break;
    }
}


- (IBAction)changeShape:(UISegmentedControl *)segmentCtrl {
    
    [_funView setShapeType:[segmentCtrl selectedSegmentIndex]];
    if ([segmentCtrl selectedSegmentIndex] == kImageShape) {
        self.colorCtrl.enabled = NO;
    } else {
        self.colorCtrl.enabled = YES;
    }
    
}

@end
