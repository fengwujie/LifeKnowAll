//
//  WJSubCategoryInfo.h
//  LifeKnowAll
//
//  Created by allen on 16/5/31.
//  Copyright © 2016年 allen. All rights reserved.
//  WJBigCategoryInfo中的childs数组模型

#import <Foundation/Foundation.h>
#import "WJCategoryInfo.h"

@interface WJSubCategoryInfo : NSObject

@property (nonatomic,strong) WJCategoryInfo *categoryInfo;

@end
