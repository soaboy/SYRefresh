//
//  UIView+SYExtension.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/26.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "UIView+SYExtension.h"

@implementation UIView (SYExtension)

- (CGFloat)sy_width
{
    return self.frame.size.width;
}

- (void)setSy_width:(CGFloat)sy_width
{
    CGRect rect=self.frame;
    rect.size.width=sy_width;
    self.frame=rect;
}

@end
