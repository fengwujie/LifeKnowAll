//
//  WJHistoryTodayResultModel.m
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayResultModel.h"

@implementation WJHistoryTodayResultModel

/**
 *  字典转模型时，属性名字不一样时，需要特别指出模型与字典的对应关系，左模型，右字典
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end
