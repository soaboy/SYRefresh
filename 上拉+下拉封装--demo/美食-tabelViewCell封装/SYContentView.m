//
//  SYContentView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/23.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYContentView.h"
#import "SYSubjectCell.h"
//#import "SYFooterView.h"
//#import "SYHeaderView.h"
#import "UITableView+SYRefresh.h"
@interface SYContentView ()

//@property(nonatomic,strong)SYFooterView *footerView;
//@property(nonatomic,strong)SYHeaderView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SYContentView

+ (id)contentView
{
//    return [[self alloc] init];
    NSArray * objs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [objs lastObject];
}


-(void)awakeFromNib
{
 
    [self.tableView addRefreshHeaderViewWithBeginRefresh:^{
        NSLog(@"刷新----更新数据中");
    }];
    
    [self.tableView addRefreshFooterViewWithBeginRefresh:^{
        NSLog(@"加载更多----下载数据中");
    }];
    
//    //添加下拉刷新
//    SYHeaderView *headView=[SYHeaderView headerView];
//    [self.tableView addSubview:headView];
//    _headView=headView;
//    _headView.delegate=self;
//    [_headView setTitle:@"下拉有惊喜" forStatus:SYRefreshStatusBeginDrag];
//    [_headView setTitle:@"松开你试试" forStatus:SYRefreshStatusDragging];
//    [_headView setTitle:@"惊喜马上送到..." forStatus:SYRefreshStatusLoading];
//    
//    //添加上拉加载更多
//    SYFooterView *footView=[SYFooterView footerView];
//    [self.tableView addSubview:footView];
//    _footerView=footView;
//    _footerView.delegate=self;
//    [footView setTitle:@"拖拽吧，骚年" forStatus:SYRefreshStatusBeginDrag];
//    [footView setTitle:@"放手才是爱" forStatus:SYRefreshStatusDragging];
//    [footView setTitle:@"在很努力加载呢..." forStatus:SYRefreshStatusLoading];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subjectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYSubjectCell *cell=[SYSubjectCell subejctCellWithTableView:tableView];
    SYSubject *model=_subjectArray[indexPath.row];
    cell.subject=model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.footerView stopAnimation];
//    [self.headView stopAnimation];
    [self.tableView headerEndRefreshing];
    [self.tableView FooterEndRefreshing];

}

#pragma mark---SYFooterViewDelegate

/*
- (void)footerViewStatus:(SYFooterView *)footerView status:(SYRefreshStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:2];
}

- (void)sendRequest
{
    NSLog(@"网络请求结束");
    [_footerView stopAnimation];
}

#pragma mark---SYHeaderViewDelegate

- (void)headerViewStatus:(SYHeaderView *)headerView status:(SYRefreshStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRefreshRequest) withObject:self afterDelay:3];
}
- (void)sendRefreshRequest
{
    NSLog(@"网络请求结束");
    [_headView stopAnimation];
}*/

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.backgroundColor=[UIColor cyanColor];
    self.frame=newSuperview.bounds;
}

@end
