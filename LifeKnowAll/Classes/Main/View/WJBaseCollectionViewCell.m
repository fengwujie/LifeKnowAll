//
//  WJBaseCollectionViewCell.m
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJBaseCollectionViewCell.h"

@interface WJBaseCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *gridTitle;

@end

@implementation WJBaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGridModel:(WJGridModel *)gridModel
{
    self.gridTitle.text=gridModel.gridTitle;
}

@end
