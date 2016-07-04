//
//  WJHistoryTodayModel.m
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayModel.h"
#import "WJHistoryTodayResultModel.h"

@implementation WJHistoryTodayModel


/** 设置字典中，属性值为数组字典需要转的MODEL类型*/
+ (NSDictionary *)objectClassInArray
{
    return @{@"result" : [WJHistoryTodayResultModel class]};
}

@end
