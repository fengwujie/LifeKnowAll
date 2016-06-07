//
//  WJFoodMenuQueryController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/30.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuQueryController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
#import "WJCategoryInfo.h"
#import "WJSubCategoryInfo.h"
#import "WJBigCategoryInfo.h"
#import "WJAllCategoryInfo.h"
#import "WJAllCategoryInfoModel.h"
#import "BDDynamicTree.h"
#import "BDDynamicTreeNode.h"
#import "WJFoodMenuQueryListController.h"

@interface WJFoodMenuQueryController ()<BDDynamicTreeDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BDDynamicTree *tableTree;

/**
 *  树型控件
 */
//@property (nonatomic,strong) BDDynamicTree *dynamicTree;
/**
 *  树型控件的数据节点数组
 */
@property(nonatomic,strong) NSMutableArray *arrayNodes;

@property (weak, nonatomic) IBOutlet UITextField *txtFoodMenuName;
- (IBAction)btnSearchClick:(id)sender;
@end

@implementation WJFoodMenuQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCategoryInfoFoodModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self btnSearchClick:nil];
    return YES;
}

/**
 *  获取菜谱的所有分类
 */
-(void)getCategoryInfoFoodModel
{
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/v1/cook/category/query?key=%@",appKey];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WJLog(@"responseObject:%@", responseObject);
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJAllCategoryInfoModel *allCategoryInfoModel = [WJAllCategoryInfoModel mj_objectWithKeyValues:responseObject];
        WJLog(@"allCategoryInfoModel:%@", allCategoryInfoModel);
        WJLog(@"allCategoryInfoModel:%@", allCategoryInfoModel.result);
        [KVNProgress dismiss];
        if ([allCategoryInfoModel.retCode isEqualToString:@"200"]) {
            [self allCategoryInfoModelToNodes:allCategoryInfoModel];
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", allCategoryInfoModel.retCode,allCategoryInfoModel.msg];
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
/**
 *  返回的数据模型转成nodes数据
 *
 *  @param allCategoryInfoModel 所有标签分类模型数据
 */
- (void) allCategoryInfoModelToNodes:(WJAllCategoryInfoModel *)allCategoryInfoModel
{
    if (_arrayNodes == nil) {
        _arrayNodes = [[NSMutableArray alloc] init];
    }
    WJAllCategoryInfo *all = allCategoryInfoModel.result;
    //获取顶级节点的子节点数组
    NSMutableArray *allSubNodes = [NSMutableArray array];
    for (WJBigCategoryInfo *bigCategoryInfo in all.childs) {
        [allSubNodes addObject:[self createTreeNodeWith:bigCategoryInfo.categoryInfo isDepartment:YES]];
    }
    
    [self addNodes:all.categoryInfo isDepartment:YES subNodes:allSubNodes];   //添加顶层节点，全部菜谱节点
    for (WJBigCategoryInfo *bigCategoryInfo in all.childs) {
        
        //获取大类节点的子节点数组（即具体分类）
        NSMutableArray *bigSubNodes = [NSMutableArray array];
        for (WJSubCategoryInfo *subCategoryInfo in bigCategoryInfo.childs) {
            [bigSubNodes addObject:[self createTreeNodeWith:subCategoryInfo.categoryInfo isDepartment:YES]];
        }
        [self addNodes:bigCategoryInfo.categoryInfo isDepartment:YES subNodes:bigSubNodes];   //添加大分类节点，，按菜品选择菜谱、按菜系选择菜谱。。。。
        //添加大分类下的小分类
        for (WJSubCategoryInfo *categoryInfo in bigCategoryInfo.childs) {
            [self addNodes:categoryInfo.categoryInfo isDepartment:NO subNodes:nil];   //添加小分类
        }
    }
    
    self.tableTree.treeNodes = self.arrayNodes;
    self.tableTree.delegate = self;
     [self.tableTree expandRoot];
}
/**
 *  添加分类数据到arrayNodes中
 *
 *  @param categoryInfo WJCategoryInfo模型
 *  @param isDepartment 是否为部门级别，如果不是最底层节点，则为YES
 */
- (void) addNodes:(WJCategoryInfo *)categoryInfo isDepartment:(BOOL)isDepartment subNodes:(NSArray *)subNodes
{
    
    BDDynamicTreeNode *node = [[BDDynamicTreeNode alloc] init];
    node.isDepartment = isDepartment;
    node.fatherNodeId = categoryInfo.parentId;
    node.nodeId = categoryInfo.ctgId;
    node.name = categoryInfo.name;
    node.data = @{@"name" : categoryInfo.name};
    node.subNodes = subNodes;
    node.isOpen = YES;
    if (categoryInfo.parentId==nil) {
        node.originX = 20.f;
    }
    
    [_arrayNodes addObject:node];
    
}
/**
 *  增加某个节点的子级节点信息
 *
 *  @param childs       节点的子级节点数组
 *  @param isDepartment 是否为部门，如果不是底级节点则为TRUE
 *
 *  @return 返回某个节点的子级节点数据
 */
- (BDDynamicTreeNode *) createTreeNodeWith: (WJCategoryInfo *)categoryInfo isDepartment:(BOOL)isDepartment
{
    BDDynamicTreeNode *node = [[BDDynamicTreeNode alloc] init];
    node.isDepartment = isDepartment;
    node.fatherNodeId = categoryInfo.parentId; ;
    node.nodeId = categoryInfo.ctgId;
    node.name = categoryInfo.name;
    node.data = @{@"name" : categoryInfo.name};
    return node;
}

-(void)dynamicTree:(BDDynamicTree *)dynamicTree didSelectedRowWithNode:(BDDynamicTreeNode *)node
{
    if (node.isDepartment!=YES) {
        [self presentVCwithMenuName:nil cid:node.nodeId name:node.name];
    }
    
}

/**
 *  跳转到菜谱列表
 *
 *  @param menuName 搜索的菜谱名称
 *  @param cid      标签ID
 *  @param name     标签名称
 */
-(void) presentVCwithMenuName:(NSString *)menuName cid:(NSString *)cid name:(NSString *)name{
    WJFoodMenuQueryListController *vc=[[WJFoodMenuQueryListController alloc] init];
    vc.menuName = menuName;
    vc.cid = cid;
    vc.title = menuName ==nil ? name : menuName;
    //vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  搜索菜谱名称
 */
- (IBAction)btnSearchClick:(id)sender {
    [self presentVCwithMenuName:self.txtFoodMenuName.text cid:nil name:nil];
    
    /*
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    if (self.txtFoodMenuName.text== nil || [self.txtFoodMenuName.text isEqualToString:@""]) {
        [KVNProgress showErrorWithStatus:@"菜谱名称不允许为空！"];
        return;
    }
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/v1/cook/menu/search?key=%@&name=%@",appKey, self.txtFoodMenuName.text];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WJLog(@"responseObject:%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJFoodMultipleModel *foodMultipleModel = [WJFoodMultipleModel mj_objectWithKeyValues:responseObject];
        WJLog(@"foodMultipleModel:%@", foodMultipleModel);
        WJLog(@"foodMultipleModel:%@", foodMultipleModel.result);
        if ([foodMultipleModel.retCode isEqualToString:@"200"]) {
            
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", foodMultipleModel.retCode,foodMultipleModel.msg];
            WJLog(@"%@", strError);
            [KVNProgress showErrorWithStatus:strError];
        }
        [KVNProgress dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        WJLog(@"%@", [error localizedDescription]);
        [KVNProgress showErrorWithStatus:[error localizedDescription]];
        [KVNProgress dismiss];
    }];
     */
}

@end
