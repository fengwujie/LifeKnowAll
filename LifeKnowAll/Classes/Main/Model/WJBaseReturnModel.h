//
//  WJBaseReturnModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJBaseReturnModel : NSObject

/**
 *  返回码
 系统级错误码参照：
 错误码	说明
 10001	appkey不合法
 10020	接口维护
 10021	接口停用
 200	成功
 应用级错误码参照：
 错误码	说明
 20101	查询不到相关数据
 20102	手机号码格式错误
 */
@property (nonatomic , copy) NSString *retCode;
/**
 *  返回说明
 */
@property (nonatomic , copy) NSString *msg;

@end
