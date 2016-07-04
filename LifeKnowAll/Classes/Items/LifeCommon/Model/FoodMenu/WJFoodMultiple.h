//
//  WJFoodMultiple.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  按菜谱名称查询返回多个菜谱信息的模型

#import <Foundation/Foundation.h>

@interface WJFoodMultiple : NSObject

/**
 *  当前页
 */
@property (nonatomic , assign) int curPage;

/**
 *  菜谱总条数
 */
@property (nonatomic , assign) int total;
/**
 *  菜谱列表
 */
@property (nonatomic , strong) NSArray *list;
@end
