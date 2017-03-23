//
//  CustomContactsVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CustomContactsVC.h"
#import <Contacts/Contacts.h>

/*
 
    1 要在info.plist中设置权限 NSContactsUsageDescription
    2 判断当前系统是 IOS10之后 还是之前 分别用不同的框架进行处理
 
 */
@interface CustomContactsVC ()

@end

@implementation CustomContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData_IOS10];
    [self initCusContactsUI];
    
}

- (void)initCusContactsUI
{
    self.navigationItem.title = @"自定义通讯录";
    [self.view addSubview:self.tableView];
    
}

- (void)loadData_IOS10
{
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized)
    {
        NSLog(@"没有授权...");
    }
    
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSLog(@"-------------------------------------------------------");
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers)
        {
            NSString *label = labelValue.label;
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSLog(@"label=%@, phone=%@", label, phoneNumber.stringValue);
            
            NSString *allName = [NSString stringWithFormat:@"%@%@", familyName, givenName];
            NSString *phoneNo = [NSString stringWithFormat:@"%@", phoneNumber.stringValue];
            [self addDataWithTitle:allName andDetail:phoneNo];
        }
        
        //    *stop = YES; // 停止循环，相当于break；
    }];
    [self.tableView reloadData];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
