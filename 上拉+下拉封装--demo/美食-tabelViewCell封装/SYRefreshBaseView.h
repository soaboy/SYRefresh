//
//  SYRefreshBaseView.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SYRefreshStatusBeginDrag,//拖拽读取更多
    SYRefreshStatusDragging,//松开读取更多
    SYRefreshStatusLoading//正在读取
}SYRefreshStatus;

@interface SYRefreshBaseView : UIView
{
    UIScrollView *_scrollView;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)SYRefreshStatus status;
- (void)setTitle:(NSString *)title forStatus:(SYRefreshStatus)status;
- (void)stopAnimation;
@end
