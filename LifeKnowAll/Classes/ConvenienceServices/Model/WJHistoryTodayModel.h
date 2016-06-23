//
//  WJHistoryTodayModel.h
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//  历史上的今天模型

#import "WJBaseReturnModel.h"
#import "WJHistoryTodayResultModel.h"

@interface WJHistoryTodayModel : WJBaseReturnModel

/**
 *  返回结果集
 */
@property (nonatomic , strong) NSArray *result;

@end
