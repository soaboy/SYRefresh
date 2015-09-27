//
//  UITableView+SYRefresh.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/28.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SYRefresh)

/**
 *  添加下拉刷新HeaderView
 *
 *  @param beginRefresh 开始刷新时需要执行的操作，如网络请求等
 */
- (void)addRefreshHeaderViewWithBeginRefresh:(void (^)())beginRefresh;

/**
 *  结束下拉刷新
 */
- (void)headerEndRefreshing;

/**
 *  添加下拉刷新FooterView
 *
 *  @param beginRefresh 开始刷新时需要执行的操作，如网络请求等
 */
- (void)addRefreshFooterViewWithBeginRefresh:(void (^)())beginRefresh;

/**
 *  结束下拉刷新
 */
- (void)FooterEndRefreshing;

@end
