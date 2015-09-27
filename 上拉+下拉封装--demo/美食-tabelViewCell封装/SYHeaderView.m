//
//  SYHeaderView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYHeaderView.h"

@interface SYHeaderView ()

@end

@implementation SYHeaderView
{
    NSString *_beginDragTitle;
    NSString *_dragTitle;
    NSString *_loadingTitle;
}

+ (id)headerView
{
    return [[self alloc] init];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status==SYRefreshStatusLoading)return;
    
    if(self.scrollView.isDragging)
    {
        //可以滚动的最大偏移量
        CGFloat maxY=-self.bounds.size.height;
        if(_scrollView.contentOffset.y<0&&_scrollView.contentOffset.y>maxY)
        {
            [self setStatus:SYRefreshStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y<=maxY)
        {
            //松开加载更多
            [self setStatus:SYRefreshStatusDragging];
        }
    }
    else
    {
        if (self.status == SYRefreshStatusDragging)
        {
            [self setStatus:SYRefreshStatusLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            
            //给代理赋值
//            [self.delegate headerViewStatus:self status:SYRefreshStatusLoading];
            //执行刷新block
            if(self.beginRefreshingBlock)
                self.beginRefreshingBlock();
        }
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //添加
//    UITableView *tableView=(UITableView *)newSuperview;
    [super willMoveToSuperview:newSuperview];
    CGFloat selfX=0;
    CGFloat selfW=_scrollView.frame.size.width;
    CGFloat selfH=60;
    CGFloat selfY=-selfH;
    
    self.backgroundColor=[UIColor cyanColor];
    self.frame=CGRectMake(selfX, selfY, selfW, selfH);
}

- (void)didMoveToSuperview
{
    self.scrollView =self.superview;
}


@end
