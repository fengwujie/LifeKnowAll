//
//  WJIdentityCardQueryReturnModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/23.
//  Copyright © 2016年 allen. All rights reserved.
//  身份证号模型——详情信息

#import <Foundation/Foundation.h>

@interface WJIdentityCardQueryReturnModel : NSObject
/**
 *  所属地区
 */
@property (nonatomic , copy) NSString *area;
/**
 *  生日
 */
@property (nonatomic , copy) NSString *birthday;
/**
 *  性别
 */
@property (nonatomic , copy) NSString *sex;
@end
