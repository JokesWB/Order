//
//  LGTableView.h
//  点餐
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGTableView;

@protocol LGTableViewDelegate <NSObject>

@optional
- (void)view:(LGTableView *)lgView didSelectRowAtIndexPath:(NSIndexPath *)indexPath Title:(NSString *)title;

@end

@interface LGTableView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *leftTableView;
    UITableView *rightTableView;
    NSInteger _count;   //分区数
    BOOL isRight;
}

@property (nonatomic , strong) NSArray *titleArray;  //标题
@property (nonatomic , strong) NSMutableArray *detailArray;
@property (nonatomic , assign) id<LGTableViewDelegate> delegate;


@end
