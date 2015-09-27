//
//  SYContentView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/23.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYContentView.h"
#import "SYFooterView.h"
#import "SYSubjectCell.h"
#import "SYHeaderView.h"

@interface SYContentView ()<SYFooterViewDelegate,SYHeaderViewDelegate>

@property(nonatomic,strong)SYFooterView *footerView;
@property(nonatomic,strong)SYHeaderView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SYContentView

+ (id)contentView
{
//    return [[self alloc] init];
    NSArray * objs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [objs lastObject];
}

//- (SYFooterView *)footerView
//{
//    if(_footerView==nil)
//    {
//        SYFooterView *footView=[SYFooterView footerView];
////        [self.tableView addSubview:footView];
//        _footerView=footView;
//        footView.scrollView=self.tableView;
//    }
//    return _footerView;
//}

-(void)awakeFromNib
{
    //添加下拉刷新
    SYHeaderView *headView=[SYHeaderView headerView];
    [self.tableView addSubview:headView];
    _headView=headView;
    _headView.delegate=self;
    [_headView setTitle:@"下拉有惊喜" forStatus:SYRefreshHeaderViewStatusBeginDrag];
    [_headView setTitle:@"松开你试试" forStatus:SYRefreshHeaderViewStatusDragging];
    [_headView setTitle:@"惊喜马上送到..." forStatus:SYRefreshHeaderViewStatusLoading];
    
    //添加上拉加载更多
    SYFooterView *footView=[SYFooterView footerView];
    [self.tableView addSubview:footView];
    _footerView=footView;
    _footerView.delegate=self;
    [footView setTitle:@"拖拽吧，骚年" forStatus:SYRefreshFooterViewStatusBeginDrag];
    [footView setTitle:@"放手才是爱" forStatus:SYRefreshFooterViewStatusDragging];
    [footView setTitle:@"在很努力加载呢..." forStatus:SYRefreshFooterViewStatusLoading];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subjectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    SYSubjectCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    SYSubjectCell *cell=[SYSubjectCell subejctCellWithTableView:tableView];
    SYSubject *model=_subjectArray[indexPath.row];
    cell.subject=model;
    
    //    NSLog(@"%p",cell);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
//    //移除当前显示的FootView
//    [_footerView removeFromSuperview];
    [self.footerView stopAnimation];
}

#pragma mark---SYFooterViewDelegate
- (void)footerViewStatus:(SYFooterView *)footerView status:(SYRefreshFooterViewStatus)status
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
- (void)headerViewStatus:(SYHeaderView *)headerView status:(SYRefreshHeaderViewStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(sendRefreshRequest) withObject:self afterDelay:3];
}
- (void)sendRefreshRequest
{
    NSLog(@"网络请求结束");
    [_headView stopAnimation];
}
/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"开始拖拽");
//    _footerView =[SYFooterView footerView];
//    [_footerView setTitle:@"拖拽吧，骚年" forStatus:SYRefreshFooterViewStatusBeginDrag];
//    [_footerView setTitle:@"放手才是爱" forStatus:SYRefreshFooterViewStatusDragging];
//    [_footerView setTitle:@"在很努力加载呢..." forStatus:SYRefreshFooterViewStatusLoading];
//    [self.tableView addSubview:_footerView];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //可以滚动的最大偏移量
    CGFloat maxY=self.tableView.contentSize.height-self.frame.size.height;
    if(scrollView.contentOffset.y>=maxY&&scrollView.contentOffset.y<maxY+_footerView.frame.size.height)
    {
        [_footerView setStatus:SYRefreshFooterViewStatusBeginDrag];
    }
    else if(scrollView.contentOffset.y>maxY+_footerView.frame.size.height)
    {
        //松开加载更多
        [_footerView setStatus:SYRefreshFooterViewStatusDragging];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.footerView.status == SYRefreshFooterViewStatusDragging)
    {
        [self.footerView setStatus:SYRefreshFooterViewStatusLoading];
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.footerView.frame.size.height, 0);
    }
}

 */



- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.backgroundColor=[UIColor cyanColor];
    self.frame=newSuperview.bounds;
}

@end
