//
//  SYSubject.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "SYSubject.h"
#import "NSObject+Model.h"

@implementation SYSubject

+ (id)subjectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
