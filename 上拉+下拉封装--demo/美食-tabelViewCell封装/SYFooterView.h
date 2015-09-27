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
@protocol SYFooterViewDelegate <NSObject>

- (void)footerViewStatus:(SYFooterView *)footerView status:(SYRefreshStatus)status;

@end

@interface SYFooterView : SYRefreshBaseView
@property (nonatomic,weak)id<SYFooterViewDelegate>delegate;
@property (nonatomic, copy)     void (^beginRefreshingBlock)();
+ (id)footerView;
@end
