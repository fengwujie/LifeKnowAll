//
//  WJRecipe.m
//  LifeKnowAll
//
//  Created by allen on 16/5/30.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJRecipe.h"
#import "MJExtension.h"
#import "WJMethod.h"
@implementation WJRecipe

/** 设置字典中，属性值为数组字典需要转的MODEL类型*/
+ (NSDictionary *)objectClassInArray
{
    return @{@"method" : [WJMethod class]};
}

@end
