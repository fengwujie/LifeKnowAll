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
#import "WJCategoryInfoFoodModel.h"
#import "BDDynamicTree.h"
#import "BDDynamicTreeNode.h"

@interface WJFoodMenuQueryController ()<BDDynamicTreeDelegate>

/**
 *  树型控件
 */
@property (nonatomic,strong) BDDynamicTree *dynamicTree;
/**
 *  树型控件的数据节点数组
 */
@property(nonatomic,strong) NSMutableArray *arrayNodes;

@end

@implementation WJFoodMenuQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor grayColor];
    [self getCategoryInfoFoodModel];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        WJCategoryInfoFoodModel *categoryInfoFoodModel = [WJCategoryInfoFoodModel mj_objectWithKeyValues:responseObject];
        WJLog(@"categoryInfoFoodModel:%@", categoryInfoFoodModel);
        WJLog(@"categoryInfoFoodModel.result:%@", categoryInfoFoodModel.result);
        if ([categoryInfoFoodModel.retCode isEqualToString:@"200"]) {
            [self modelToNodes:categoryInfoFoodModel];
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", categoryInfoFoodModel.retCode,categoryInfoFoodModel.msg];
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
}
/**
 *  返回的数据模型转成nodes数据
 *
 *  @param categoryInfoFoodModel 模型数据
 */
- (void) modelToNodes:(WJCategoryInfoFoodModel *)categoryInfoFoodModel
{
    if (_arrayNodes == nil) {
        _arrayNodes = [[NSMutableArray alloc] init];
    }
    WJAllCategoryInfo *all = categoryInfoFoodModel.result;
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
    
    _dynamicTree = [[BDDynamicTree alloc] initWithFrame:CGRectMake(0, 100, 300, 300) nodes:self.arrayNodes];
    //_dynamicTree.backgroundColor = [UIColor grayColor];
    _dynamicTree.delegate = self;
    [self.view addSubview:_dynamicTree];
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

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self getCategoryInfoFoodModel];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
