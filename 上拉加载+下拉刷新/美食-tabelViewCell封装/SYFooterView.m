//
//  SYFooterView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/23.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYFooterView.h"

@interface SYFooterView ()

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,weak)UIButton *alertBtnView;
@property (nonatomic,weak)UIView *loadingView;


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

- (void)stopAnimation
{
    _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
//    [self removeFromSuperview];
    [self clear];
}

- (void)clear
{
    [self.alertBtnView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    //结束加载后更改下次的状态为下拉
    self.status=SYRefreshFooterViewStatusBeginDrag;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
        //移除旧的监听
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        _scrollView=scrollView;
        //添加新的监听
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
//     [self.scrollView addSubview:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status==SYRefreshFooterViewStatusLoading)return;
    [self willMoveToSuperview:_scrollView];
    if(self.scrollView.isDragging)
    {
        //可以滚动的最大偏移量
        CGFloat maxY=_scrollView.contentSize.height-_scrollView.frame.size.height;
        if(_scrollView.contentOffset.y>=maxY&&_scrollView.contentOffset.y<maxY+self.frame.size.height)
        {
            [self setStatus:SYRefreshFooterViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y>maxY+self.frame.size.height)
        {
            //松开加载更多
            [self setStatus:SYRefreshFooterViewStatusDragging];
        }
    }
    else
    {
        if (self.status == SYRefreshFooterViewStatusDragging)
        {
            [self setStatus:SYRefreshFooterViewStatusLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            
            [self.delegate footerViewStatus:self status:SYRefreshFooterViewStatusLoading];
            
        }
    }
}

- (UIButton *)alertBtnView
{
    if(_alertBtnView==nil)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=self.bounds;
        [self addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        _alertBtnView=button;
    }
    return _alertBtnView;
}

- (UIView *)loadingView
{
    if(_loadingView==nil)
    {
        UIView *ldView=[[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:ldView];
        _loadingView = ldView;
        ldView.frame = self.bounds;
        
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [ldView addSubview:labelTitle];
        labelTitle.text = [self titleWithStatus:SYRefreshFooterViewStatusLoading];
        labelTitle.frame = ldView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        //创建繁忙提示
        UIActivityIndicatorView *indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [ldView addSubview:indicatorView];
        indicatorView.frame=CGRectMake(36, 20, 20, 20);
        [indicatorView startAnimating];
    }
    return _loadingView;
}

- (void)setTitle:(NSString *)title forStatus:(SYRefreshFooterViewStatus)status
{
    switch (status) {
        case SYRefreshFooterViewStatusBeginDrag:
            _beginDragTitle=title;
            break;
            
        case SYRefreshFooterViewStatusDragging:
            _dragTitle=title;
            break;
            
        case SYRefreshFooterViewStatusLoading:
            _loadingTitle=title;
            break;
            
        default:
            break;
    }
    
    [self titleWithStatus:status];
    
}

- (NSString *)titleWithStatus:(SYRefreshFooterViewStatus)status
{
    NSString *title=nil;
    
    switch (status) {
        case SYRefreshFooterViewStatusBeginDrag:
            //            NSLog(@"拖拽读取更多");
            title =_beginDragTitle?_beginDragTitle:@"拖拽加载更多";
            break;
            
        case SYRefreshFooterViewStatusDragging:
            //            NSLog(@"松开读取更多");
            title =_dragTitle?_dragTitle:@"松开加载更多";
            break;
            
        case SYRefreshFooterViewStatusLoading:
            //            NSLog(@"正在读取");
            
            title=_loadingTitle?_loadingTitle:@"正在加载";
            break;
            
        default:
            break;
    }

    return title;
}



- (void)setStatus:(SYRefreshFooterViewStatus)status
{
    _status=status;
    switch (status) {
        case SYRefreshFooterViewStatusBeginDrag:
//            [self.alertBtnView setHidden:NO];
//            NSLog(@"拖拽读取更多");
//            [self.alertBtnView setTitle:@"拖拽加载更多" forState:UIControlStateNormal];
            [self.alertBtnView setTitle:[self titleWithStatus:SYRefreshFooterViewStatusBeginDrag] forState:UIControlStateNormal];
            break;
            
        case SYRefreshFooterViewStatusDragging:
//            NSLog(@"松开读取更多");
//            [self.alertBtnView setTitle:@"松开读取更多" forState:UIControlStateNormal];
            [self.alertBtnView setTitle:[self titleWithStatus:SYRefreshFooterViewStatusDragging] forState:UIControlStateNormal];
            break;

        case SYRefreshFooterViewStatusLoading:
//            NSLog(@"正在读取");
            [self.alertBtnView setHidden:YES];
            [self loadingView];
            break;
            
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
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
