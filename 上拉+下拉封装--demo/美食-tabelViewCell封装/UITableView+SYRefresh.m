//
//  UITableView+SYRefresh.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/28.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "UITableView+SYRefresh.h"
#import "SYHeaderView.h"
#import "SYFooterView.h"
#import "objc/runtime.h"
@interface UITableView()
@property (nonatomic, weak) SYHeaderView *header;
@property (nonatomic, weak) SYFooterView *footer;

@end


@implementation UITableView (SYRefresh)

#pragma mark - 关联属性
static char SYRefreshHeaderViewKey;
static char SYRefreshFooterViewKey;

- (void)setHeader:(SYHeaderView *)header {
    [self willChangeValueForKey:@"SYRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &SYRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"JHRefreshHeaderViewKey"];
}

- (SYHeaderView *)header {
    return objc_getAssociatedObject(self, &SYRefreshHeaderViewKey);
}


- (void)setFooter:(SYFooterView *)footer {
    [self willChangeValueForKey:@"SYRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &SYRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"SYRefreshFooterViewKey"];
}

- (SYFooterView *)footer {
    return objc_getAssociatedObject(self, &SYRefreshFooterViewKey);
}



#pragma mark -
- (void)addRefreshHeaderViewWithBeginRefresh:(void (^)())beginRefresh;
{
    if(!self.header)
    {
        SYHeaderView *headerView = [SYHeaderView headerView];
        headerView.beginRefreshingBlock = beginRefresh;
        [self addSubview:headerView];
        self.header = headerView;
    }
}

- (void)headerEndRefreshing
{
    [self.header stopAnimation];
}

#pragma mark -
- (void)addRefreshFooterViewWithBeginRefresh:(void (^)())beginRefresh;
{
    if(!self.footer)
    {
        SYFooterView *footerView = [SYFooterView footerView];
        footerView.beginRefreshingBlock = beginRefresh;
        [self addSubview:footerView];
        self.footer=footerView;
    }
}

- (void)FooterEndRefreshing
{
    [self.footer stopAnimation];
}


@end
