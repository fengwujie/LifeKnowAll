//
//  WJHistoryTodayResultModel.h
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//  历史上的今天模型——今天详情模型

#import <Foundation/Foundation.h>

@interface WJHistoryTodayResultModel : NSObject

/*
 date	string	日期
 month	string	月份
 day	string	天
 title	int	标题
 event	int	事件
 */

/**
*  日期
*/
@property (nonatomic,copy) NSString *date;

/**
 *  月份
 */
@property (nonatomic,assign) int month;

/**
 *  天
 */
@property (nonatomic,assign) int day;

/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;

/**
 *  事件
 */
@property (nonatomic,copy) NSString *event;


/**
 *  id
 */
@property (nonatomic,copy) NSString *ID;

@end
