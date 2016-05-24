//
//  WJBaseItemViewController.h
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//  各个item页签基类，主要是菜单数据处理

#import <UIKit/UIKit.h>

@interface WJBaseItemViewController : UIViewController
/**
 *  网格需要显示的列数
 */
@property (nonatomic , assign) int iCellCount;
/**
 *  GRID网格的数据数组
 */
@property (nonatomic , strong) NSArray *arrayGridModel;
/**
 *  GRID网格
 */
@property (nonatomic , weak) UICollectionView *collectionView;
@end
