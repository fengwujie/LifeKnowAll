//
//  WJCategoryInfoFoodModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  菜谱分类标签模型，是个树形资料

#import "WJBaseReturnModel.h"
#import "WJAllCategoryInfo.h"

@interface WJAllCategoryInfoModel : WJBaseReturnModel

/**
 *  返回结果集
 */
@property (nonatomic , strong) WJAllCategoryInfo *result;

@end
