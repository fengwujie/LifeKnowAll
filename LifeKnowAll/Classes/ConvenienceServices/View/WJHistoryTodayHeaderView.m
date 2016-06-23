//
//  MJHeaderView.m
//  03-QQ好友列表
//
//  Created by apple on 14-4-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "WJHistoryTodayHeaderView.h"
#import "WJHistoryTodayGroupModel.h"

/**
 某个控件出不来:
 1.frame的尺寸和位置对不对
 
 2.hidden是否为YES
 
 3.有没有添加到父控件中
 
 4.alpha 是否 < 0.01
 
 5.被其他控件挡住了
 
 6.父控件的前面5个情况
 */

@interface WJHistoryTodayHeaderView()
//@property (nonatomic, weak) UILabel *countView;
@property (nonatomic, weak) UIButton *nameView;
@end

@implementation WJHistoryTodayHeaderView

+ (instancetype)historyTodayHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"historyTodayHeader";
    WJHistoryTodayHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[WJHistoryTodayHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

/**
 *  在这个初始化方法中,MJHeaderView的frame\bounds没有值
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 1.添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
//        // 设置按钮内部的左边箭头图片
//        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
//        nameView.imageEdgeInsets
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameView.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
//        // 2.添加好友数
//        UILabel *countView = [[UILabel alloc] init];
//        countView.textAlignment = NSTextAlignmentRight;
//        countView.textColor = [UIColor grayColor];
//        [self.contentView addSubview:countView];
//        self.countView = countView;
    }
    return self;
}

/**
 *  当一个控件的frame发生改变的时候就会调用
 *
 *  一般在这里布局内部的子控件(设置子控件的frame)
 */
- (void)layoutSubviews
{
#warning 一定要调用super的方法
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    self.nameView.frame = self.bounds;
    
//    // 2.设置好友数的frame
//    CGFloat countY = 0;
//    CGFloat countH = self.frame.size.height;
//    CGFloat countW = 150;
//    CGFloat countX = self.frame.size.width - 10 - countW;
//    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)setGroup:(WJHistoryTodayGroupModel *)group
{
    _group = group;
    
    // 1.设置按钮文字(组名)
    [self.nameView setTitle:group.title forState:UIControlStateNormal];
    
//    // 2.设置好友数(在线数/总数)
//    self.countView.text = [NSString stringWithFormat:@"%d/%d", group.online, group.friends.count];
}

/**
 *  监听组名按钮的点击
 */
- (void)nameViewClick
{
    // 1.修改组模型的标记(状态取反)
    self.group.opened = !self.group.isOpened;
    
    // 2.刷新表格
    if ([self.delegate respondsToSelector:@selector(historyTodayHeaderViewDidClickedNameView:)]) {
        [self.delegate historyTodayHeaderViewDidClickedNameView:self];
    }
}

///**
// *  当一个控件被添加到父控件中就会调用
// */
//- (void)didMoveToSuperview
//{
//    if (self.group.opened) {
//        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//    } else {
//        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
//    }
//}

/**
 *  当一个控件即将被添加到父控件中会调用
 */
//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    
//}
@end
