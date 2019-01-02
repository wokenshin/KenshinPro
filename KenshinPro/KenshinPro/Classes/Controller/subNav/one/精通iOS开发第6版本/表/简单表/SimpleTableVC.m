//
//  SimpleTableVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "SimpleTableVC.h"
#import "JTiOSDevVC.h"

@interface SimpleTableVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray   *arrData;
@property (nonatomic, assign) NSInteger countInitObj;

@end

@implementation SimpleTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"简单表";
    _arrData = @[@"这一行是无法选中的", @"这一行选中后 有动画效果", @"tatiya", @"minami", @"goku", @"karote",
                 @"buma", @"kulin", @"yamutia", @"孙悟饭", @"孙悟天", @"孙悟空",
                 @"琪琪",
                 @"kenshin", @"sukuragi", @"tatiya", @"minami", @"goku", @"karote",
                 @"buma", @"kulin", @"yamutia", @"孙悟饭", @"孙悟天", @"孙悟空",
                 @"琪琪"];
    
//    //下面的代码原本是偏移值，目的是不影响状态栏，但是很早之前就已经不需要这么做了
//    UITableView *tableView = (id)[self.view viewWithTag:1];
//    UIEdgeInsets contentInset = tableView.contentInset;
//    contentInset.top = 20;
//    [tableView setContentInset:contentInset];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;//指定行高
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableID = @"simpleTableID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableID];
        NSLog(@"创建cell：%ld", (long)_countInitObj++);
    }
    //文本
    cell.textLabel.text = _arrData[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    UIImage *img = [UIImage imageNamed:@"yingmu_guilian"];
    UIImage *img2 = [UIImage imageNamed:@"yingmu_ok"];
    
    //图片
    cell.imageView.image = img;
    cell.imageView.highlightedImage = img2;//卧槽！
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"这一行是无法选中的";
    }
    if (indexPath.row > 9) {
        cell.detailTextLabel.text = @"大噶好，我是详细标签。哈哈哈哈哈哈哈哈哈哈";
        //注意：UITableViewCellStyleDefault样式并不包含详细文本，所以必须修改到对应的样式，表的内容才会生效
        //eg:UITableViewCellStyleSubtitle
    }
    else{
        cell.detailTextLabel.text = @"";//必须有这一行，不然重绘的时候，上面的详细文本的内容会跑到先前没有详细文本的cell中
    }
    
    /*
     UITableViewCellStyleDefault  只显示 文本 和 图片
     UITableViewCellStyleSubtitle 图片 和 （文本+详细文本） 水平布局， 文本垂直布局
     UITableViewCellStyleValue1   图片，文本，详细文本 水平布局
     UITableViewCellStyleValue2   只显示文本 和详细文本
     */
    return cell;
}

//缩进 文本缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row;
}

//选择某行时 先调用次方法 之后才会触发 didSelectRowAtIndexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return nil;//禁止选中 第一行
    }
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *rowValue = _arrData[indexPath.row];
    NSString *message  = [NSString stringWithFormat:@"You selected %@", rowValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row selected!"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Yes I Iid"
                                          otherButtonTitles:nil];
    [alert show];
    
    if (indexPath.row == 1) {
        //这行代码有什么卵用？
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        /*
         用处：
         问题1：有没有遇到过，导航+UITableView，在push，back回来之后，当前cell仍然是选中的状态
         解决方法：添加一句[tableView deselectRowAtIndexPath:indexPath animated:YES]即可
         
         问题2: 令人纠结的是，在没加这句的时候，有的视图同样回来之后，选中状态消失，为什么会出现这种情况呢？
         原来是，如果UITableView是在UITableViewController中时，就会默然取消，而如果是在UIViewController时，
         需要添加这一句，不过有时即使前者也需要添加，那是因为在视图加载时有其它功能代码，具体情况各异。
         所以后者必须加，前者可能需要加。
         
         
         不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态。
         加上此句，返回时直接就是非选中状态。
         
         */
        
        [self pushToTmpVC];
    }
    if (indexPath.row == 2) {
        [self pushToTmpVC];
    }
    
}

- (void)pushToTmpVC{
    
    JTiOSDevVC *vc = [[JTiOSDevVC alloc] init];
    [self performSelector:@selector(titleName:) withObject:vc afterDelay:0.5];
    UIView *emptView = [[UIView alloc] initWithFrame:self.view.bounds];
    emptView.backgroundColor = [UIColor grayColor];
    [vc.view addSubview:emptView];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)titleName:(JTiOSDevVC *)vc{
    vc.title = @"无用的控制器";
}

@end
