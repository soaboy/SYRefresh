//
//  ViewController.m
//  美食-tabelViewCell封装
//
//  Created by soaboy on 15/9/22.
//  Copyright (c) 2015年 soaboy. All rights reserved.
//

#import "ViewController.h"
#import "SYSubjectCell.h"
#import "SYSubject.h"
#import "SYFooterView.h"
#import "SYContentView.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *plist;
@property (nonatomic,strong)NSArray *subjectArray;

@end

@implementation ViewController

- (NSArray *)plist
{
    if(_plist==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"quanquan.plist" ofType:nil];
        NSArray *tem=[NSArray arrayWithContentsOfFile:path];
        _plist=tem;
    }
    return _plist;
}

- (NSArray *)subjectArray
{
    if(_subjectArray==nil)
    {
        NSArray *dicts=_plist[1];
        
        NSMutableArray *arrayM=[NSMutableArray array];
        for (NSDictionary *dict in dicts) {
            SYSubject *model=[SYSubject subjectWithDict:dict];
            [arrayM addObject:model];
        }
        _subjectArray=arrayM;
    }
    return _subjectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    [_tableView registerNib:[UINib nibWithNibName:@"SYSubjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self plist];
    [self subjectArray];
    
    SYContentView *contentView=[SYContentView contentView];
    [self.view addSubview:contentView];
    contentView.subjectArray=_subjectArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
