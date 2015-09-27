//
//  SYFooterView.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/23.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYRefreshBaseView.h"
@class SYFooterView;

typedef enum {
    SYRefreshFooterViewStatusBeginDrag,//拖拽读取更多
    SYRefreshFooterViewStatusDragging,//松开读取更多
    SYRefreshFooterViewStatusLoading//正在读取
}SYRefreshFooterViewStatus;

@protocol SYFooterViewDelegate <NSObject>

- (void)footerViewStatus:(SYFooterView *)footerView status:(SYRefreshFooterViewStatus)status;

@end

@interface SYFooterView : SYRefreshBaseView
@property(nonatomic,assign)SYRefreshFooterViewStatus status;
@property (nonatomic,weak)id<SYFooterViewDelegate>delegate;

+ (id)footerView;
- (void)setTitle:(NSString *)title forStatus:(SYRefreshFooterViewStatus)status;
- (void)stopAnimation;
@end
