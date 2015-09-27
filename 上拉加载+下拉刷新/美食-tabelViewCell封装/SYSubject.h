//
//  SYSubject.h
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYSubject : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * cardNumber;
@property(nonatomic,copy) NSString * note;
@property(nonatomic,copy) NSString * icon;

+(id)subjectWithDict:(NSDictionary *)dict;
@end
