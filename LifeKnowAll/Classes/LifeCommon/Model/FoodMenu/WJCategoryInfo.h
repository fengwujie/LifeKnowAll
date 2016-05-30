//
//  WJCategoryInfo.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  分类基本信息

#import <Foundation/Foundation.h>

@interface WJCategoryInfo : NSObject

/**
 *  分类ID
 */
@property (nonatomic , copy) NSString *ctgId;
/**
 *  分类描述
 */
@property (nonatomic , copy) NSString *name;
/**
 *  上层分类ID
 */
@property (nonatomic , copy) NSString *parentId;
@end
