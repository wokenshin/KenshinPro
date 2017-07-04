//
//  BigSmallVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BigSmallVC.h"


//http://www.jianshu.com/p/754d5f1a3f3d

@interface BigSmallVC ()


@property (weak, nonatomic) IBOutlet UITextField *text;

@property (weak, nonatomic) IBOutlet UILabel *labBig;

@property (weak, nonatomic) IBOutlet UILabel *labSmall;


@end

@implementation BigSmallVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"大小端转换";
    
}


- (IBAction)clickSaveData:(id)sender
{
    int value = [_text.text intValue];
    
    
    
    NSMutableData *dataTest = [NSMutableData dataWithLength:4];
    
    uint32_t bigValue = value;
    
    bigValue    = OSSwapHostToBigInt32((uint32_t)bigValue);//小端->大端
    
    [dataTest replaceBytesInRange:NSMakeRange(0, 4) withBytes:&bigValue length:4];
    
    
    
    
    NSMutableData *dataTest2 = [NSMutableData dataWithLength:4];
    
    uint32_t smalValue = value;
    
    [dataTest2 replaceBytesInRange:NSMakeRange(0, 4) withBytes:&smalValue length:4];
    
    NSString *bigStr   = [NSString stringWithFormat:@"大端结果: %@", dataTest];
    NSString *smallStr = [NSString stringWithFormat:@"小端结果: %@", dataTest2];
    
    NSLog(@"%@", bigStr);
    NSLog(@"%@", smallStr);
    
    _labBig.text   = bigStr;
    _labSmall.text = smallStr;
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
