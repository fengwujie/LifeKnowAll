//
//  WJSingleFoodModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  返回结果 - 单个菜谱模型

#import "WJBaseReturnModel.h"
#import "WJFood.h"

@interface WJSingleFoodModel : WJBaseReturnModel

/**
 *  返回结果集
 */
@property (nonatomic , strong) WJFood *result;

@end
