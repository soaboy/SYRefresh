//
//  SYSubjectCell.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYSubject.h"

@interface SYSubjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)SYSubject * subject;
+(id)subejctCellWithTableView:(UITableView *)tableView;
@end
