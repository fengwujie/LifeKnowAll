//
//  WJIPAddressReturnModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/23.
//  Copyright © 2016年 allen. All rights reserved.
//  IP模型-IP详情模型

#import <Foundation/Foundation.h>

@interface WJIPAddressReturnModel : NSObject

/**
*  IP
*/
@property (nonatomic , copy) NSString *ip;
/**
 *  国家
 */
@property (nonatomic , copy) NSString *country;
/**
 *  省
 */
@property (nonatomic , copy) NSString *province;
/**
 *  市
 */
@property (nonatomic , copy) NSString *city;
///**
// *  区
// */
//@property (nonatomic , copy) NSString *district;
@end
