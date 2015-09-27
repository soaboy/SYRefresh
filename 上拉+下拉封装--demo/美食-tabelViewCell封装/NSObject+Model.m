//
//  NSObject+Model.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)

+ (id)objectWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    //无法使用super，这里使用self，因为该类中没有init方法，会默认调用父类的init方法，
    //即[super init]
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
