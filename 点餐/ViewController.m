//
//  ViewController.m
//  点餐
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "ViewController.h"
#import "LGTableView.h"

@interface ViewController ()<LGTableViewDelegate>
{
    NSArray *titleArray;
    NSMutableArray *detailArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    detailArray = [NSMutableArray array];
    
    titleArray = [NSArray arrayWithObjects:@"荤菜", @"素菜", @"不混不素菜", @"好吃点", @"想吃啥", @"哈哈哈", @"逗你玩", nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"鸡肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"鸭肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"牛肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array4 = [NSArray arrayWithObjects:@"猪肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array5 = [NSArray arrayWithObjects:@"羊肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array6 = [NSArray arrayWithObjects:@"狗肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    NSArray *array7 = [NSArray arrayWithObjects:@"兔肉", @"鱼肉", @"大白菜", @"萝卜", nil];
    [detailArray addObject:array1];
    [detailArray addObject:array2];
    [detailArray addObject:array3];
    [detailArray addObject:array4];
    [detailArray addObject:array5];
    [detailArray addObject:array6];
    [detailArray addObject:array7];
    
    
    
    LGTableView *tabView = [[LGTableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    tabView.titleArray = titleArray;
    tabView.detailArray = detailArray;
    tabView.delegate = self;
    [self.view addSubview:tabView];
    
    
}

#pragma mark - LGTableViewDelegate
- (void)view:(LGTableView *)lgView didSelectRowAtIndexPath:(NSIndexPath *)indexPath Title:(NSString *)title
{
    NSLog(@"%ld, %ld, title = %@", indexPath.section, indexPath.row, title);
}

@end
