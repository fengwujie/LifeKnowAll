//
//  WJNumberLocationModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//  手机号码归属模型

#import <Foundation/Foundation.h>
#import "WJNumberLocationResultModel.h"
#import "WJBaseReturnModel.h"

@interface WJNumberLocationModel : WJBaseReturnModel

/**
 *  返回结果集
 */
@property (nonatomic , strong) WJNumberLocationResultModel *result;
@end
