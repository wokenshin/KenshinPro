//
//  TouchExplorerVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/23.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "TouchExplorerVC.h"

@interface TouchExplorerVC ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapsLabel;
@property (weak, nonatomic) IBOutlet UILabel *touchesLabel;

@end

@implementation TouchExplorerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势-多点触摸";
}

- (void)updateLabelsFromTouches:(NSSet *)touches{
    
    NSUInteger numTaps = [[touches anyObject] tapCount];
    NSString *tapsMessage = [NSString stringWithFormat:@"%lu taps detected", (unsigned long)numTaps];
    self.tapsLabel.text = tapsMessage;
    
    NSUInteger numTouches = [touches count];
    NSString *touchMsg = [NSString stringWithFormat:@"%lu touches detected", (unsigned long)numTouches];
    self.touchesLabel.text = touchMsg;
    
}

#pragma mark - Touch Event Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"Touches Began";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"touches Cancelled";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"touches Ended";
    [self updateLabelsFromTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"touches Moved";
    [self updateLabelsFromTouches:touches];
}
@end
