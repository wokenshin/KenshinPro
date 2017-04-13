//
//  DeviceMenuView.m
//  Sanhe
//
//  Created by kenshin on 16/11/11.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "DeviceMenuView.h"

@implementation DeviceMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (IBAction)commonClick:(id)sender {
    if (self.delegate != nil) {
        [self.delegate deviceMenuSetCommon:self];
    }
}

- (IBAction)quicikClick:(id)sender {
    if (self.delegate != nil) {
        [self.delegate deviceMenuSetQuick:self];
    }
}

- (IBAction)editNameClick:(id)sender {
    if (self.delegate != nil) {
        [self.delegate deviceMenuSetName:self];
    }
}

- (IBAction)deleteClick:(id)sender {
    if (self.delegate != nil) {
        [self.delegate deviceMenuDelete:self];
    }
}










@end
