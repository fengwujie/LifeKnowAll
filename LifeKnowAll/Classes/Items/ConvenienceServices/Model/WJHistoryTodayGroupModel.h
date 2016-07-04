//
//  WJHistoryTodayGroupModel.h
//  LifeKnowAll
//
//  Created by allen on 16/6/23.
//  Copyright © 2016年 allen. All rights reserved.
//  历史上的今天分组模型，即真正在显示的数据模型

#import <Foundation/Foundation.h>
#import "WJHistoryTodayResultModel.h"

@interface WJHistoryTodayGroupModel : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  数组中装的都是MJFriend模型
 */
@property (nonatomic, strong) WJHistoryTodayResultModel *historyToday;
/**
 *  标识这组是否需要展开,  YES : 展开 ,  NO : 关闭
 */
@property (nonatomic, assign, getter = isOpened) BOOL opened;
/**
 *  历史事件的单元格高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
