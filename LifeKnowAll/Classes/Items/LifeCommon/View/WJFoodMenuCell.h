//
//  WJFoodMenuCell.h
//  LifeKnowAll
//
//  Created by allen on 16/6/7.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFood.h"

@interface WJFoodMenuCell : UITableViewCell

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) WJFood *food;

@end
