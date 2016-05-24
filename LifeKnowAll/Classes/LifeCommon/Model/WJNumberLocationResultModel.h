//
//  WJNumberLocationResultModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//  手机号码归属——手机详情模型

#import <Foundation/Foundation.h>

@interface WJNumberLocationResultModel : NSObject

/**
*  省份
*/
@property (nonatomic , copy) NSString *province;
/**
 *  城市
 */
@property (nonatomic , copy) NSString *city;
/**
 *  城市区号
 */
@property (nonatomic , copy) NSString *cityCode;
/**
 *  手机号前7位
 */
@property (nonatomic , copy) NSString *mobileNumber;

/**
 *  邮编
 */
@property (nonatomic , copy) NSString *zipCode;
/**
 *  运营商信息
 */
@property (nonatomic , copy) NSString *operatorTemp;
@end
