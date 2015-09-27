//
//  NSObject+Model.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)
+(id)objectWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
@end
