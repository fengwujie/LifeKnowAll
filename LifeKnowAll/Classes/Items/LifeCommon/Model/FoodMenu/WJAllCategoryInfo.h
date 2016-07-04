//
//  WJAllCategoryInfo.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  所有分类信息

#import <Foundation/Foundation.h>
#import "WJCategoryInfo.h"

@interface WJAllCategoryInfo : NSObject

/**
 *  最顶层分类信息，即全部菜谱那层
 */
@property (nonatomic , strong) WJCategoryInfo *categoryInfo;

/**
 *  顶层分类的子分类信息(WJBigCategoryInfo)
 */
@property (nonatomic , strong) NSArray *childs;
@end
