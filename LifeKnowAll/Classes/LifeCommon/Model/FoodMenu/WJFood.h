//
//  WJFood.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  菜谱基本模型

#import <Foundation/Foundation.h>
#import "WJRecipe.h"

@interface WJFood : NSObject

/**
 *  分类ID
 */
@property (nonatomic , strong) NSArray *ctgIds;
/**
 *  分类标签
 */
@property (nonatomic , strong) NSArray *ctgTitles;
/**
 *  菜谱id
 */
@property (nonatomic , copy) NSString *menuId;
/**
 *  菜谱名称
 */
@property (nonatomic , copy) NSString *name;
/**
 *  制作步骤
 */
@property (nonatomic , strong)  WJRecipe *recipe;
/**
 *  预览图地址
 */
@property (nonatomic , copy) NSString *thumbnail;
@end
