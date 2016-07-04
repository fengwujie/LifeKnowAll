//
//  WJHistoryTodayController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
//#import "MJRefresh.h"
#import "WJHistoryTodayModel.h"
#import "WJHistoryTodayResultModel.h"
#import "WJHistoryTodayGroupModel.h"
#import "WJHistoryTodayHeaderView.h"
#import "WJHistoryTodayCell.h"

@interface WJHistoryTodayController ()<WJHistoryTodayHeaderViewDelegate>
/**
 *  历史事件分组
 */
@property (nonatomic, strong) NSMutableArray *arrayGroup;

@end

@implementation WJHistoryTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight=200; //预估行高 可以提高性能
    self.tableView.rowHeight = 88;
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 44;
    
    //[self loadData];
    //self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadData];
    //}];
    
    //[self.tableView.mj_footer beginRefreshing];
    
}

- (NSMutableArray *)arrayGroup
{
    if (_arrayGroup == nil) {
        _arrayGroup = [NSMutableArray array];
    }
    return _arrayGroup;
}

- (void) loadData{
    
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/appstore/history/query?key=%@&day=%@",appKey, [NSDate date].dateWithMD];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WJLog(@"responseObject:%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJHistoryTodayModel *historyTodayModel = [WJHistoryTodayModel mj_objectWithKeyValues:responseObject];
        WJLog(@"historyTodayModel:%@", historyTodayModel);
        WJLog(@"historyTodayModel:%@", historyTodayModel.result);
        [KVNProgress dismiss];
        if ([historyTodayModel.retCode isEqualToString:@"200"]) {
            NSArray *resultModel = [NSArray array];
            resultModel = historyTodayModel.result;
            [self resultModelToGroupModel:resultModel];
            [self.tableView reloadData];
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", historyTodayModel.retCode,historyTodayModel.msg];
            WJLog(@"%@", strError);
            [KVNProgress showErrorWithStatus:strError];
        }
        //[self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [KVNProgress dismiss];
        // 请求失败
        WJLog(@"%@", [error localizedDescription]);
        //[self.tableView.mj_footer endRefreshing];
        [KVNProgress showErrorWithStatus:[error localizedDescription]];
    }];
}
/**
 *  结果模型转换成分组模型
 *
 *  @param resultModel 历史事件数组，里面装的是模型
 */
- (void)resultModelToGroupModel: (NSArray *)resultModel{
    for (WJHistoryTodayResultModel *result in resultModel) {
        WJHistoryTodayGroupModel *groupModel = [[WJHistoryTodayGroupModel alloc] init];
        groupModel.title =[NSString stringWithFormat:@"%@  %@",[self dateChanged:result.date], result.title]; // result.title;
        groupModel.opened = NO;
        groupModel.historyToday = result;
        [self.arrayGroup addObject:groupModel];
    }
}
/**
 *  日期格式转换，20160622转成2016年06月22日
 *
 *  @param strDate 需要转换的字符串
 *
 *  @return 返回格式为2016年06月22日
 */
- (NSString*) dateChanged:(NSString *)strDate
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    WJLog(@"strDate=%@",strDate);
    NSDate* inputDate = [inputFormatter dateFromString:strDate];
    WJLog(@"date = %@", inputDate);  // date = 2011-08-26 05:41:06 +0000
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    WJLog(@"testDate:%@", str);
    return str;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    WJHistoryTodayGroupModel *group = self.arrayGroup[section];
    return (group.isOpened ? 1 : 0);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJHistoryTodayCell *cell = [WJHistoryTodayCell cellWithTableView:tableView];
    WJHistoryTodayGroupModel *groupModel = [self.arrayGroup objectAtIndex:indexPath.section];
    WJHistoryTodayResultModel *resultModel = groupModel.historyToday;
    cell.resultModel = resultModel;
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1.创建头部控件
    WJHistoryTodayHeaderView *header = [WJHistoryTodayHeaderView historyTodayHeaderViewWithTableView:tableView];
    header.delegate = self;
    // 2.给header设置数据(给header传递模型)
    header.group = self.arrayGroup[section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJHistoryTodayGroupModel *groupModel = [self.arrayGroup objectAtIndex:indexPath.section];
    return [groupModel cellHeight];
}

- (void)historyTodayHeaderViewDidClickedNameView:(WJHistoryTodayHeaderView *)headerView{
    [self.tableView reloadData];
}

@end
