//
//  WJTabBarModel.h
//  LifeKnowAll
//
//  Created by allen on 16/5/21.
//  Copyright © 2016年 allen. All rights reserved.
//  tabbarItem的数据模型

#import <Foundation/Foundation.h>

@interface WJTabBarItemModel : NSObject

/**
 *  tabbarItem显示文本
 */
@property (nonatomic , copy) NSString *tabbarItemTitle;
/**
 *  默认图片名称
 */
@property (nonatomic , copy) NSString *imageName;
/**
 *  选中时图片名称
 */
@property (nonatomic , copy) NSString *selectedImageName;
/**
 *  对应的跳转控制器
 */
@property (nonatomic , copy) NSString *controllerView;
/**
 *  网格显示的列数
 */
@property (nonatomic , assign) int cellCount;
/**
 *  各个tabbarItem页签对应的GRID网格数据数组
 */
@property (nonatomic , strong) NSMutableArray *gridModel;    //其他对象(除代理\UI控件\字符串以外的对象)

@end
