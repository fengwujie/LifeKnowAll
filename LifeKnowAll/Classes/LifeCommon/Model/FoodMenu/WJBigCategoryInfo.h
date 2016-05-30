//
//  WJBigCategoryInfo.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  大分类基本模型，按菜品、工艺、功能等大分类

#import <Foundation/Foundation.h>
#import "WJCategoryInfo.h"

@interface WJBigCategoryInfo : NSObject

/**
 *  大分类信息
 */
@property (nonatomic , strong) WJCategoryInfo *CategoryInfo;

/**
 *  大分类下的具体分类信息，数组中存的是数据为模型WJCategoryInfo
 */
@property (nonatomic , strong) NSArray *childs;
@end
