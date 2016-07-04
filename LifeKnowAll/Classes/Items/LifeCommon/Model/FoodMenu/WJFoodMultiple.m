//
//  WJFoodMultiple.m
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMultiple.h"
#import "WJFood.h"
#import "MJExtension.h"

@implementation WJFoodMultiple

/** 设置字典中，属性值为数组字典需要转的MODEL类型*/
+ (NSDictionary *)objectClassInArray
{
    return @{@"list" : [WJFood class]};
}

@end
