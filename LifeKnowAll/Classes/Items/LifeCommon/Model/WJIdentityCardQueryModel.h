//
//  WJIdentityCardQueryModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/23.
//  Copyright © 2016年 allen. All rights reserved.
//  身份证号模型

#import "WJBaseReturnModel.h"
#import "WJIdentityCardQueryReturnModel.h"

@interface WJIdentityCardQueryModel : WJBaseReturnModel

@property (nonatomic , strong) WJIdentityCardQueryReturnModel *result;
@end
