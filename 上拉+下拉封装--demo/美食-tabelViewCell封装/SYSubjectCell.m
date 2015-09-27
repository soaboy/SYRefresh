//
//  SYSubjectCell.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYSubjectCell.h"
#import "UITableViewCell+initcell.h"

@interface SYSubjectCell ()

@end

@implementation SYSubjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setSubject:(SYSubject *)subject
{
    _subject=subject;
    self.iconView.image=[UIImage imageNamed:subject.icon];
    self.titleLabel.text=subject.title;
}



+ (id)subejctCellWithTableView:(UITableView *)tableView
{
//    NSString *className=NSStringFromClass([self class]);
//    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
//    return [tableView dequeueReusableCellWithIdentifier:className];
    
    return [self cellWithTableView:tableView];
}

@end
