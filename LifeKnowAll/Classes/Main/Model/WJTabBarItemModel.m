//
//  WJTabBarModel.m
//  LifeKnowAll
//
//  Created by allen on 16/5/21.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJTabBarItemModel.h"
#import "MJExtension.h"
#import "WJGridModel.h"

@implementation WJTabBarItemModel


/** 设置字典中，属性值为数组字典需要转的MODEL类型*/
+ (NSDictionary *)objectClassInArray
{
    return @{@"gridModel" : [WJGridModel class]};
}

@end
