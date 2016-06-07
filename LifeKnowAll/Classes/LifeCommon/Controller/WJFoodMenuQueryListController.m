//
//  WJFoodMenuQueryListController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/2.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuQueryListController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
#import "WJFood.h"
#import "WJFoodMultiple.h"
#import "WJFoodMultipleModel.h"
#import "UIImageView+WebCache.h"
#import "WJFoodMenuCell.h"
#import "MJRefresh.h"

@interface WJFoodMenuQueryListController ()

/**
 *  起始页(默认1)
 */
@property (nonatomic, assign) int page;
/**
 *  返回数据条数(默认20)
 */
@property( nonatomic , assign ) int size;
/**
 *  菜谱列表
 */
@property (nonatomic, strong) NSMutableArray *arrayFoodMenu;
@end


@implementation WJFoodMenuQueryListController

- (int)page
{
    _page +=1;
    return _page;
}

- (int)size
{
    return 20;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadData];
    }];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)arrayFoodMenu
{
    if (_arrayFoodMenu == nil) {
        _arrayFoodMenu = [NSMutableArray array];
    }
    return _arrayFoodMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData{
    
     [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
     // 初始化Manager
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     
     // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionary];
    [dicParameters setObject:appKey forKey:@"key"];
    [dicParameters setObject:@(self.page) forKey:@"page"];
    [dicParameters setObject:@(self.size) forKey:@"size"];
    //NSMutableString *param = [NSMutableString stringWithFormat:@"&page=%d&size=%d",self.page,self.size];
    if (self.menuName) {
        //[param appendString:[NSString stringWithFormat:@"&name=%@",self.menuName]];
        [dicParameters setObject:self.menuName forKey:@"name"];
    }
    if (self.cid) {
        //[param appendString:[NSString stringWithFormat:@"&cid=%@",self.cid]];
        [dicParameters setObject:self.cid forKey:@"cid"];
    }
     // Get请求
//     NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/v1/cook/menu/search?key=%@%@",appKey, param];
    NSString *strURL = @"http://apicloud.mob.com/v1/cook/menu/search";
     [manager GET:strURL parameters:dicParameters progress:^(NSProgress * _Nonnull downloadProgress) {
     // 这里可以获取到目前的数据请求的进度
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     WJLog(@"responseObject:%@", responseObject);
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
     NSLog(@"dic:%@", dic);
     
     // 请求成功，解析数据
     WJFoodMultipleModel *foodMultipleModel = [WJFoodMultipleModel mj_objectWithKeyValues:responseObject];
     WJLog(@"foodMultipleModel:%@", foodMultipleModel);
     WJLog(@"foodMultipleModel:%@", foodMultipleModel.result);
     [KVNProgress dismiss];
     if ([foodMultipleModel.retCode isEqualToString:@"200"]) {
         NSArray *arrayResult = foodMultipleModel.result.list;
         [self.arrayFoodMenu addObjectsFromArray:arrayResult];
         [self.tableView reloadData];
     }
     else
     {
         NSString *strError = [NSString stringWithFormat:@"%@%@", foodMultipleModel.retCode,foodMultipleModel.msg];
         WJLog(@"%@", strError);
         [KVNProgress showErrorWithStatus:strError];
     }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [KVNProgress dismiss];
         // 请求失败
         WJLog(@"%@", [error localizedDescription]);
         [KVNProgress showErrorWithStatus:[error localizedDescription]];
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.arrayFoodMenu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WJFoodMenuCell *cell = [WJFoodMenuCell cellWithTableView:tableView];
    cell.food = [self.arrayFoodMenu objectAtIndex:indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
