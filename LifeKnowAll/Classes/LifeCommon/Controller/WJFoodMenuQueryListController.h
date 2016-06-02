//
//  WJFoodMenuQueryListController.h
//  LifeKnowAll
//
//  Created by allen on 16/6/2.
//  Copyright © 2016年 allen. All rights reserved.
//  菜谱查询列表（根据菜谱名称或者是标签分类）

#import <UIKit/UIKit.h>

@interface WJFoodMenuQueryListController : UITableViewController

/**
 *  菜谱名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  标签分类ID
 */
@property (nonatomic,copy) NSString *cid;

@end
