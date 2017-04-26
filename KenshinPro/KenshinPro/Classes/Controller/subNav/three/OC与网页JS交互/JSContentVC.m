//
//  JSContentVC.m
//  GYBase
//
//  Created by kenshin on 16/9/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JSContentVC.h"
#import "JSONEVC.h"
#import "JSTWOVC.h"
#import "JSCallOCVC.h"
#import "JSCallOCTWOVC.h"
#import "OCToJSVC.h"
#import "OCCallJSTwoVC.h"

@interface JSContentVC ()

@end

@implementation JSContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JS交互目录";
    
}

- (IBAction)jsonE:(id)sender
{
    JSONEVC *vc = [[JSONEVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//OC调用JS
- (IBAction)tWO:(id)sender
{
    JSTWOVC *vc = [[JSTWOVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

//JS调用OC方式一
- (IBAction)jsCallOC:(id)sender
{
    JSCallOCVC *vc = [[JSCallOCVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//JS调用OC方式二
- (IBAction)jsCallOcTwo:(id)sender
{
    JSCallOCTWOVC *vc = [[JSCallOCTWOVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//OC调用JS方式一
- (IBAction)OCCallJS:(id)sender
{
    OCToJSVC *vc = [[OCToJSVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//OC调用JS方式二
- (IBAction)ocCall:(id)sender
{
    OCCallJSTwoVC *vc = [[OCCallJSTwoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
