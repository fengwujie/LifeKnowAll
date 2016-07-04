//
//  WJFoodMenuCell.m
//  LifeKnowAll
//
//  Created by allen on 16/6/7.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuCell.h"

#import "UIImageView+WebCache.h"

@interface WJFoodMenuCell()
@property (weak, nonatomic) IBOutlet UIImageView *wjImageView;

@property (weak, nonatomic) IBOutlet UILabel *wjLable;
@end

@implementation WJFoodMenuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WJFoodMenuCell";
    WJFoodMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJFoodMenuCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setFood:(WJFood *)food
{
    _food = food;
    if (_food.thumbnail == nil) {
        self.wjImageView.image = [UIImage imageNamed:@"icon_plus"];
    }
    else
    {
//        [self.wjImageView sd_setImageWithURL:[NSURL URLWithString:_food.thumbnail] placeholderImage:[UIImage imageNamed:@"2"]];
        [self.wjImageView sd_setImageWithURL:[NSURL URLWithString:_food.thumbnail] placeholderImage:[UIImage imageNamed:@"2"] options:SDWebImageProgressiveDownload];
    }
    self.wjLable.text = _food.name;
}

@end
