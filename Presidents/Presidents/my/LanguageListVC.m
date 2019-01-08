//
//  LanguageListVC.m
//  Presidents
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 kenshin. All rights reserved.
//

#import "LanguageListVC.h"
#import "DetailViewController.h"

@interface LanguageListVC ()

@end

@implementation LanguageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.languageNames = @[@"English", @"French", @"German", @"Spanish"];
    self.languageCodes = @[@"en", @"fr", @"de", @"es"];
    
    self.clearsSelectionOnViewWillAppear = NO;
    //如果不指定size 这里的弹出窗口会平铺整个设备屏幕
    self.preferredContentSize = CGSizeMake(320, [self.languageCodes count] * 44);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.languageCodes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.languageNames[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailVC.languageString = self.languageCodes[indexPath.row];
}
@end
