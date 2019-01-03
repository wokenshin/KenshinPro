//
//  FontSizeVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FontSizeVC.h"

@interface FontSizeVC ()

@end

@implementation FontSizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)pointSize{
    static NSArray *pointSize = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pointSize = @[@9,
                      @10,
                      @11,
                      @12,
                      @13,
                      @14,
                      @18,
                      @24,
                      @36,
                      @48,
                      @64,
                      @72,
                      @96,
                      @144];
    });
    return pointSize;
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *pointSize = [self pointSize][indexPath.row];
    return [self.font fontWithSize:pointSize.floatValue];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self pointSize] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"FontSizeCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    
    //配置表单元
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.font.fontName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ point", [self pointSize][indexPath.row]];
    return cell;
}

@end
