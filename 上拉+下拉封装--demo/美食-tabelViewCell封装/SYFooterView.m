//
//  SYFooterView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/23.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYFooterView.h"

@interface SYFooterView ()

//@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,weak)UIButton *alertBtnView;
//@property (nonatomic,weak)UIView *loadingView;


@end

@implementation SYFooterView
{
    NSString *_beginDragTitle;
    NSString *_dragTitle;
    NSString *_loadingTitle;
}


+ (id)footerView
{
    return [[self alloc] init];
}

- (void)dealloc
{
    //控件被移除，同时移除监听
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status==SYRefreshStatusLoading)return;
    [self willMoveToSuperview:_scrollView];
    if(self.scrollView.isDragging)
    {
        NSLog(@"%@",NSStringFromCGPoint(self.scrollView.contentOffset));
        //可以滚动的最大偏移量
        CGFloat maxY=_scrollView.contentSize.height-_scrollView.frame.size.height;
        if(_scrollView.contentOffset.y>=maxY&&_scrollView.contentOffset.y<maxY+self.frame.size.height)
        {
            [self setStatus:SYRefreshStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y>maxY+self.frame.size.height)
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
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            
//            [self.delegate footerViewStatus:self status:SYRefreshStatusLoading];
            //执行刷新block
            if(self.beginRefreshingBlock)
                self.beginRefreshingBlock();
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    //添加
    UITableView *tableView=(UITableView *)newSuperview;
    
    CGFloat selfX=0;
    CGFloat selfY=tableView.contentSize.height;
    CGFloat selfW=tableView.frame.size.width;
    CGFloat selfH=60;
    self.backgroundColor=[UIColor orangeColor];
    self.frame=CGRectMake(selfX, selfY, selfW, selfH);
    
    //    self.scrollView=newSuperview;
}

- (void)didMoveToSuperview
{
    self.scrollView=(UIScrollView *)self.superview;
}

@end
