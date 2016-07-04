//
//  WJHistoryTodayCell.h
//  LifeKnowAll
//
//  Created by allen on 16/6/23.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJHistoryTodayResultModel;

static NSString *historyTodayCellIdentifier = @"historyTodayCell";

@interface WJHistoryTodayCell : UITableViewCell

/**
 *  数据模型
 */
@property (nonatomic, strong) WJHistoryTodayResultModel *resultModel;

/**
 *  最后得到CELL高度的方法
 *
 *  @param resultModel WJHistoryTodayResultModel数据模型
 *
 *  @return 返回CELL的高度
 */
- (CGFloat)cellHeightWithModel:(WJHistoryTodayResultModel *)resultModel;

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


/**
 *  定义一个descLabel文本高度的属性
 */
@property (nonatomic,assign) CGFloat descLabelH;

@end
