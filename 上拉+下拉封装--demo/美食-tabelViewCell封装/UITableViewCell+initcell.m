//
//  UITableViewCell+initcell.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "UITableViewCell+initcell.h"
#import "SYFooterView.h"

@implementation UITableViewCell (initcell)

+ (id)cellWithTableView:(UITableView *)tableView
{
    NSString *className=NSStringFromClass([self class]);
    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    
//    SYFooterView *footerView=[SYFooterView footerView];
//    footerView.backgroundColor=[UIColor orangeColor];
//    [tableView addSubview:footerView];
    
    return [tableView dequeueReusableCellWithIdentifier:className];
}

@end
