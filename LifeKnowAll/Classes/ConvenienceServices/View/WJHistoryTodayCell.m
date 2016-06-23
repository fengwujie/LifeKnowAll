//
//  WJHistoryTodayCell.m
//  LifeKnowAll
//
//  Created by allen on 16/6/23.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayCell.h"
#import "Masonry.h"
#import "WJHistoryTodayResultModel.h"

//间距
#define  marginW 10
#define historyTodayCellFont [UIFont systemFontOfSize:17]
@interface WJHistoryTodayCell()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation WJHistoryTodayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    WJHistoryTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:historyTodayCellIdentifier];
    if (!cell) {
        cell = [[WJHistoryTodayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyTodayCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //1.添加子控件
        [self setupUI];
        
    }
    return self;
    
}

/**
 *  传递数据模型
 */
- (void)setResultModel:(WJHistoryTodayResultModel *)resultModel
{
    _resultModel = resultModel;
    self.descLabel.text = resultModel.event;
}


#pragma mark 添加子控件
-(void)setupUI
{
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.textColor = [UIColor blackColor];
    self.descLabel.font = historyTodayCellFont;
    self.descLabel.numberOfLines = 0;
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.descLabel];
    
    //设置约束
    __weak __typeof(&*self)weakSelf = self;
    //2.设置contentLabel
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(marginW); //文本距离头像底部10个间距
        make.left.equalTo(weakSelf.mas_left).offset(marginW);  //文本距离左边的距离
        make.right.equalTo(weakSelf.mas_right).offset(-marginW);  //文本距离右边的距离
        
        //文本高度 我们再得到模型的时候 在传递
    }];
}

- (CGFloat)cellHeightWithModel:(WJHistoryTodayResultModel *)resultModel{
    _resultModel=resultModel;
    __weak __typeof(&*self)weakSelf = self;
    //设置标签的高度
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // weakSelf.contentLabelH  这个会调用下面的懒加载方法
        make.height.mas_equalTo(weakSelf.descLabelH);
    }];
    
    // 2. 更新约束
    [self layoutIfNeeded];
    
    //3.  视图的最大 Y 值
    CGFloat h= CGRectGetMaxY(self.descLabel.frame);
    
    return h;  //h+marginW; //最大的高度+10
}

/*
 *  懒加载的方法返回contentLabel的高度  (只会调用一次)
 */
-(CGFloat)descLabelH
{
    if(!_descLabelH){
        CGFloat h=[self.resultModel.event boundingRectWithSize:CGSizeMake(([UIScreen mainScreen].bounds.size.width)-2*marginW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:historyTodayCellFont} context:nil].size.height;
        
        _descLabelH=h ;  //h+marginW;  //内容距离底部下划线10的距离
    }
    return _descLabelH;
}


@end
