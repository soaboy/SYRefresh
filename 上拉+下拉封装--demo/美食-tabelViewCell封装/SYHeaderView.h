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
@protocol SYHeaderViewDelegate <NSObject>
- (void)headerViewStatus:(SYHeaderView *)headerView status:(SYRefreshStatus)status;
@end

@interface SYHeaderView : SYRefreshBaseView

@property (nonatomic,weak)id<SYHeaderViewDelegate>delegate;
@property (nonatomic, copy)     void (^beginRefreshingBlock)();

+ (id)headerView;
@end
