//
//  SYHeaderView.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYRefreshBaseView.h"
@class SYHeaderView;
typedef enum {
    SYRefreshHeaderViewStatusBeginDrag,//拖拽读取更多
    SYRefreshHeaderViewStatusDragging,//松开读取更多
    SYRefreshHeaderViewStatusLoading//正在读取
}SYRefreshHeaderViewStatus;

@protocol SYHeaderViewDelegate <NSObject>

- (void)headerViewStatus:(SYHeaderView *)headerView status:(SYRefreshHeaderViewStatus)status;

@end

@interface SYHeaderView : SYRefreshBaseView
@property(nonatomic,assign)SYRefreshHeaderViewStatus status;
@property (nonatomic,weak)id<SYHeaderViewDelegate>delegate;

+ (id)headerView;
- (void)setTitle:(NSString *)title forStatus:(SYRefreshHeaderViewStatus)status;
- (void)stopAnimation;
@end
