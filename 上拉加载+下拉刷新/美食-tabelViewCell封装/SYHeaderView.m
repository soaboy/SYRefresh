//
//  SYHeaderView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYHeaderView.h"

@interface SYHeaderView ()

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,weak)UIButton *alertBtnView;
@property (nonatomic,weak)UIView *loadingView;
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

- (void)stopAnimation
{
    self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self clear];
}

- (void)clear
{
    [_alertBtnView removeFromSuperview];
    [_loadingView removeFromSuperview];
    self.status=SYRefreshHeaderViewStatusBeginDrag;
}

- (void)setTitle:(NSString *)title forStatus:(SYRefreshHeaderViewStatus)status
{
    switch (status) {
        case SYRefreshHeaderViewStatusBeginDrag:
            _beginDragTitle=title;
            break;
            
        case SYRefreshHeaderViewStatusDragging:
            _dragTitle=title;
            break;
            
        case SYRefreshHeaderViewStatusLoading:
            _loadingTitle=title;
            break;
            
        default:
            break;
    }
}

- (NSString *)titleWithStatus:(SYRefreshHeaderViewStatus)status
{
    NSString *title=nil;
    switch (status) {
        case SYRefreshHeaderViewStatusBeginDrag:
            title=_beginDragTitle?_beginDragTitle:@"下拉刷新";
            break;
            
        case SYRefreshHeaderViewStatusDragging:
            title=_dragTitle?_dragTitle:@"松开刷新";
            break;
            
        case SYRefreshHeaderViewStatusLoading:
            title=_loadingTitle?_loadingTitle:@"正在加载";
            break;
            
        default:
            break;
    }
    return title;
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
        labelTitle.text = [self titleWithStatus:SYRefreshHeaderViewStatusLoading];
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

- (void)setScrollView:(UIScrollView *)scrollView
{
    //移除旧监听
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //添加监听
    //保存成员变量
    _scrollView=scrollView;
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status==SYRefreshHeaderViewStatusLoading)return;
    
    if(self.scrollView.isDragging)
    {
        //可以滚动的最大偏移量
        CGFloat maxY=-self.bounds.size.height;
        if(_scrollView.contentOffset.y<0&&_scrollView.contentOffset.y>maxY)
        {
            [self setStatus:SYRefreshHeaderViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y<=maxY)
        {
            //松开加载更多
            [self setStatus:SYRefreshHeaderViewStatusDragging];
        }
    }
    else
    {
        if (self.status == SYRefreshHeaderViewStatusDragging)
        {
            [self setStatus:SYRefreshHeaderViewStatusLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            
            //给代理赋值
            [self.delegate headerViewStatus:self status:_status];
        }
    }
}

- (void)setStatus:(SYRefreshHeaderViewStatus)status
{
    _status=status;
    switch (status) {
        case SYRefreshHeaderViewStatusBeginDrag:
            [self.alertBtnView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
            
            case SYRefreshHeaderViewStatusDragging:
            [self.alertBtnView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
            
            case SYRefreshHeaderViewStatusLoading:
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
    CGFloat selfW=tableView.frame.size.width;
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
