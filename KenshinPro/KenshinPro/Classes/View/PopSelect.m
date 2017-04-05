//
//  OrdersDropdownSelection.m
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import "PopSelect.h"

@interface PopSelect ()
{
    AppDelegate     *appDelegate;
    
    NSArray         *ordersarray;
    
}
@end
@implementation PopSelect

-(void)alertTableview:(NSArray *)Contentarray title:(NSString *)title resultBlock:(IntBlock )block
{
    
    [self addTarget:self action:@selector(CloseAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.4];
    completionBlock = block;

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Title = title;

    
   DropdownTable=[[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-(self.frame.size.width/1.2)/2,self.frame.size.height/2-(self.frame.size.height/3)/2,self.frame.size.width/1.2,self.frame.size.height/3)];
    DropdownTable.backgroundColor = [UIColor whiteColor];
    DropdownTable.dataSource = self;
    DropdownTable.delegate = self;
    DropdownTable.showsVerticalScrollIndicator = YES;
    DropdownTable.bounces = NO;
    DropdownTable.layer.cornerRadius = 5.0f;
    DropdownTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self addSubview:DropdownTable];

    ordersarray = [[NSArray alloc]initWithArray:Contentarray];
    
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone, self.alpha=1;)completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.frame.size.height/4;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    [myview setBackgroundColor:RGB(227, 9, 50)];
    
    UILabel *headLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, myview.frame.size.width, tableView.frame.size.height/4)];
    headLbl.backgroundColor = [UIColor clearColor];
    headLbl.textColor = [UIColor whiteColor];
    headLbl.text = Title?Title:@"Select";
    headLbl.textAlignment = NSTextAlignmentCenter;
    headLbl.font = AvenirMedium(18);
    [myview addSubview:headLbl];
    
    
    return myview;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height/4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ordersarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    UILabel *Contentlbl =[[UILabel alloc]initWithFrame:CGRectMake(10,0,tableView.frame.size.width-20,tableView.frame.size.height/4)];
    Contentlbl.backgroundColor = [UIColor clearColor];
    Contentlbl.text = [ordersarray objectAtIndex:indexPath.row];
    Contentlbl.textColor = [UIColor blackColor];
    Contentlbl.textAlignment = NSTextAlignmentLeft;
    Contentlbl.font = AvenirMedium(16);
    [cell.contentView addSubview:Contentlbl];

    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Contentlbl.frame.origin.y+Contentlbl.frame.size.height-2,self.frame.size.width, 1.2)];
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [Contentlbl addSubview:lineView];
    
    if(indexPath.row == [ordersarray count] -1){
        
        lineView.hidden=YES;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor=RGB(248, 218, 218);
    
    if (completionBlock)
    {
        completionBlock((int)indexPath.row);
    }
    
    [self CloseAnimation];
    
}

-(void)CloseAnimation
{
    NormalAnimation(self.superview, 0.30f,UIViewAnimationOptionTransitionNone, DropdownTable.alpha=0;)
        completion:^(BOOL finished){

    [DropdownTable removeFromSuperview];
            [self removeFromSuperview];
    }];
    
}

@end
