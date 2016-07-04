//
//  WJFoodMultipleModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  根据菜谱名称查询，返回来的数据集

#import "WJBaseReturnModel.h"
#import "WJFoodMultiple.h"

@interface WJFoodMultipleModel : WJBaseReturnModel

/**
 *  返回结果集
 */
@property (nonatomic , strong) WJFoodMultiple *result;

@end
