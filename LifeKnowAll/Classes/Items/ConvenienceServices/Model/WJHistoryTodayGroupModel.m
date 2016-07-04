//
//  WJHistoryTodayGroupModel.m
//  LifeKnowAll
//
//  Created by allen on 16/6/23.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayGroupModel.h"
#import "WJHistoryTodayCell.h"
@implementation WJHistoryTodayGroupModel

//惰性初始化是这样写的
-(CGFloat)cellHeight
{
    //只在初始化的时候调用一次就Ok
    if(!_cellHeight){
        WJHistoryTodayCell *cell=[[WJHistoryTodayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyTodayCellIdentifier];
        // 调用cell的方法计算出高度
        _cellHeight=[cell cellHeightWithModel:self.historyToday];
    }
    
    return _cellHeight;
}

@end
