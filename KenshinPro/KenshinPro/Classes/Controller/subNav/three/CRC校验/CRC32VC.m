//
//  CRC32VC.m
//  KenshinPro
//
//  Created by kenshin on 17/6/1.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CRC32VC.h"
#import "NSData+CRC32.h"

@interface CRC32VC ()

@end

@implementation CRC32VC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self toast:@"看代码"];
    
    NSData *data = [NSData data];//加入这是你需要校验的数据
    
    int32_t checksum = [data crc32];//将数据进行CRC32的计算 得到一个4个字节 即32位的一个数，这个数就是通过CRC32计算得到的数
    
    //大概意思：在给硬件传输较大数据的时候，为了保证传输数据的正确性，通常可以再传递一个参数给硬件，作为校验参数
    //方法有多重，较为常用的就是CRC校验了，在吧数据全部传输到硬件之后，硬件也会拿传输过去的较大数据进行CRC校验
    //如果硬件校验的结果==我们传输过去的校验结果 那么说明传输的较大数据是正确的，反之则不正确。 这就是CRC校验的意义
    
    
}



@end
