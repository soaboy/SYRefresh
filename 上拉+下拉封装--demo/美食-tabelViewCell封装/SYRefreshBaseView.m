//
//  SYRefreshBaseView.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYRefreshBaseView.h"
#import "UIView+SYExtension.h"

@interface SYRefreshBaseView ()
@property (nonatomic,weak)UIButton *alertBtnView;
@property (nonatomic,weak)UIView *loadingView;
@end

@implementation SYRefreshBaseView
{
    NSString *_beginDragTitle;
    NSString *_dragTitle;
    NSString *_loadingTitle;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.sy_width=newSuperview.sy_width;
    
    //移除旧监听
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //添加监听
    [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    _scrollView=(UIScrollView *)newSuperview;
}


- (void)stopAnimation
{
    _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self clear];
}

- (void)clear
{
    [self.alertBtnView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    //结束加载后更改下次的状态为下拉
    self.status=SYRefreshStatusBeginDrag;
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
        labelTitle.text = [self titleWithStatus:SYRefreshStatusLoading];
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


- (void)setTitle:(NSString *)title forStatus:(SYRefreshStatus)status
{
    switch (status) {
        case SYRefreshStatusBeginDrag:
            _beginDragTitle=title;
            break;
            
        case SYRefreshStatusDragging:
            _dragTitle=title;
            break;
            
        case SYRefreshStatusLoading:
            _loadingTitle=title;
            break;
            
        default:
            break;
    }
}

- (NSString *)titleWithStatus:(SYRefreshStatus)status
{
    NSString *title=nil;
    
    switch (status) {
        case SYRefreshStatusBeginDrag:
            //            NSLog(@"拖拽读取更多");
            title =_beginDragTitle?_beginDragTitle:@"拖拽加载更多";
            break;
            
        case SYRefreshStatusDragging:
            //            NSLog(@"松开读取更多");
            title =_dragTitle?_dragTitle:@"松开加载更多";
            break;
            
        case SYRefreshStatusLoading:
            //            NSLog(@"正在读取");
            title=_loadingTitle?_loadingTitle:@"正在加载";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (void)setStatus:(SYRefreshStatus)status
{
    _status=status;
    switch (status) {
        case SYRefreshStatusBeginDrag:
            [[self alertBtnView] setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
            
        case SYRefreshStatusDragging:
            [self.alertBtnView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
            
        case SYRefreshStatusLoading:
            [self.alertBtnView setHidden:YES];
            [self loadingView];
            break;
            
        default:
            break;
    }
    
}

@end
