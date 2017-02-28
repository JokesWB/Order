//
//  LGTableView.m
//  点餐
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LGTableView.h"

@implementation LGTableView

- (NSMutableArray *)detailArray
{
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 4, self.frame.size.height) style:UITableViewStylePlain];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.tag = 100;
        [self addSubview:leftTableView];
        
        rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftTableView.frame), 0, self.frame.size.width * 3 / 4, self.frame.size.height) style:UITableViewStylePlain];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.tag = 200;
        [self addSubview:rightTableView];
        
        isRight = YES;
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == leftTableView) {
        return 1;
    }
    _count = self.titleArray.count;
    return _count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == leftTableView) {
        return self.titleArray.count;
    }
//    NSLog(@"===%ld", [self.detailArray[section] count]);
    return [self.detailArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == leftTableView) {
        //默认选中第一行
//        [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        cell.backgroundColor = [UIColor redColor];
        UIView *view = [[UIView alloc] initWithFrame:cell.frame];
        view.backgroundColor = [UIColor yellowColor];
        cell.selectedBackgroundView = view;
        cell.textLabel.text = self.titleArray[indexPath.row];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
        cell.textLabel.text = self.detailArray[indexPath.section][indexPath.row];
        //没有选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableView *tableView1 = (UITableView *)[self viewWithTag:100];
    UITableView *tableView2 = (UITableView *)[self viewWithTag:200];
    //如果选中左边的
    if (tableView == tableView1) {
        isRight = NO;
        //让右边相应的区头滚动到上部
        [tableView2 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    } else if (tableView == tableView2) {
        //右边的
        if ([self.delegate respondsToSelector:@selector(view:didSelectRowAtIndexPath:Title:)]) {
            [self.delegate view:self didSelectRowAtIndexPath:indexPath Title:self.detailArray[indexPath.section][indexPath.row]];
        }
    }
}


//区头标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == rightTableView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightTableView.frame.size.width, 30)];
        label.text = self.titleArray[section];
        label.backgroundColor = [UIColor greenColor];

        return label;
    }
    return nil;
}

//区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == rightTableView) {
        return 30;
    }
    return 0;
}

//返回每一个区尾的高度，这个高度必须有，不然就不会出现想要的那个效果
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(tableView == leftTableView)
    {
        return 0;
    }
    return 0.5;   //这个太小的话，就没反应了
}

//将要展示的区头视图
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (isRight) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        NSLog(@"---------------topCellSection = %ld", topCellSection);
        if (tableView == rightTableView) {
            [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

//已经展示的区尾视图
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (isRight) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        NSLog(@">>>>>>>>%ld", [[[tableView indexPathsForVisibleRows] firstObject] section]);
        if (tableView == rightTableView) {
            [leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}


#pragma mark UISCrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isRight = YES;
}


@end
