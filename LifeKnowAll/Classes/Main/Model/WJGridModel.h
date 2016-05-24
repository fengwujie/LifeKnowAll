//
//  WJGridModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/21.
//  Copyright © 2016年 allen. All rights reserved.
//  每个GRID单元格的模型

#import <Foundation/Foundation.h>

@interface WJGridModel : NSObject
/**
 *  GRID网格显示的文本内容
 */
@property (nonatomic , copy) NSString *gridTitle;   //字符串

/**
 *  GRID网格对应的跳转视图名称
 */
@property (nonatomic , copy) NSString *controllerView;   //字符串
/**
 *  控制是否显示当前GRID
 */
@property (nonatomic , assign, getter=isVisble) BOOL visible;    // 非对象类型(基本数据类型int\float\BOOL\枚举\结构体)
/**
 *  GRID网格的图片
 */
@property (nonatomic , copy) NSString *imageName;   //字符串
@end
