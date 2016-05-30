//
//  WJRecipe.h
//  LifeKnowAll
//
//  Created by allen on 16/5/30.
//  Copyright © 2016年 allen. All rights reserved.
//  制作步骤

#import <Foundation/Foundation.h>

@interface WJRecipe : NSObject
/**
 *  图片
 */
@property (nonatomic , copy) NSString *img;

/**
 *  成分
 */
@property (nonatomic , copy) NSString *ingredients;
/**
 *  综述
 */
@property (nonatomic , copy) NSString *sumary;
/**
 *  标题
 */
@property (nonatomic , copy) NSString *title;
/**
 *  方法(WJMethod)
 */
@property (nonatomic , strong) NSArray *method;
@end
