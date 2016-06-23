//
//  WJHistoryTodayHeaderView.h
//
//  Created by apple on 14-4-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJHistoryTodayGroupModel, WJHistoryTodayHeaderView;


@protocol WJHistoryTodayHeaderViewDelegate <NSObject>
@optional
- (void)historyTodayHeaderViewDidClickedNameView:(WJHistoryTodayHeaderView *)headerView;
@end

@interface WJHistoryTodayHeaderView : UITableViewHeaderFooterView
+ (instancetype)historyTodayHeaderViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) WJHistoryTodayGroupModel *group;

@property (nonatomic, weak) id<WJHistoryTodayHeaderViewDelegate> delegate;

@end
