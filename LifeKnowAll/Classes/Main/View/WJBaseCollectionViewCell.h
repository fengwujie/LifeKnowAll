//
//  WJBaseCollectionViewCell.h
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGridModel.h"

@interface WJBaseCollectionViewCell : UICollectionViewCell

/**
 *  数据模型
 */
@property (nonatomic , strong) WJGridModel *gridModel;

@end
