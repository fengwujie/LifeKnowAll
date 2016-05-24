//
//  WJTabBarViewController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/21.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJTabBarViewController.h"
#import "WJTabBarItemModel.h"
#import "WJGridModel.h"
#import "MJExtension.h"
#import "WJNavigationViewController.h"
#import "WJBaseItemViewController.h"

#define MenuPath [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Menu.plist"]
@interface WJTabBarViewController ()
/**
 *  菜单数组
 */
@property (nonatomic , strong) NSMutableArray *arrayMenu;    //其他对象(除代理\UI控件\字符串以外的对象)

@end

@implementation WJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (WJTabBarItemModel *tabBarItemModel in self.arrayMenu) {
        //WJLog(@"%@:%@",tabBarItemModel.tabbarItemTitle,tabBarItemModel.gridModel);
        [self addChildVc:tabBarItemModel];
    }
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}

-(NSArray *)arrayMenu
{
    if (!_arrayMenu) {
        NSArray *array = [NSArray arrayWithContentsOfFile:MenuPath];
        //WJLog(@"array---%@",array);
        _arrayMenu = [WJTabBarItemModel mj_objectArrayWithKeyValuesArray:array];
        //WJLog(@"_arrayMenu---%@",_arrayMenu);
        
        NSInteger iCountM = _arrayMenu.count - 1;
        //循环tabbarItem主菜单数据，倒序
        for (NSInteger indexM = iCountM; indexM>=0; indexM--)
        {
            WJTabBarItemModel *itemM = [_arrayMenu objectAtIndex:indexM];
            NSInteger iCountD = itemM.gridModel.count-1;
            //循环tabbarItem主菜单数据中的GridModel数组
            for (NSInteger indexD = iCountD; indexD>=0; indexD--)
            {
                WJGridModel *itemD = (WJGridModel *)[itemM.gridModel objectAtIndex:indexD];
                if (itemD.isVisble == NO) {
                    [itemM.gridModel removeObject:itemD];
                }
            }
        }
//        //先循环item大数组
//        [_arrayMenu enumerateObjectsUsingBlock:^(id  _Nonnull objM, NSUInteger idx, BOOL * _Nonnull stop) {
//            //再对item里面的gridModel数组进行循环，删除不显示的内容
//            NSMutableArray *gridModel =((WJTabBarItemModel *)objM).gridModel;
//            [gridModel enumerateObjectsUsingBlock:^(id  _Nonnull objD, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (((WJGridModel *)objD).isVisble == NO) {
//                    [gridModel removeObject:objD];
//                }
//            }];
//        }];
    }
    return _arrayMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  添加子控制器
 *
 *  @param tabbarItemModel item的数据模型
 */
- (void)addChildVc:(WJTabBarItemModel *)tabbarItemModel
{
    WJBaseItemViewController *childVc = (WJBaseItemViewController *)[[NSClassFromString(tabbarItemModel.controllerView) alloc] init];
    //childVc.view.backgroundColor = WJRandomColor;
    //childVc.tabBarItem.title = title;
    childVc.arrayGridModel = tabbarItemModel.gridModel;
    childVc.iCellCount = tabbarItemModel.cellCount;
    childVc.title = tabbarItemModel.tabbarItemTitle;
    if(tabbarItemModel.imageName && tabbarItemModel.imageName.length>0)
    {
        childVc.tabBarItem.image = [UIImage imageNamed: tabbarItemModel.imageName];
    }
    if(tabbarItemModel.selectedImageName && tabbarItemModel.selectedImageName.length>0)
    {
        // 图片按原始样子显示，不自动渲染成其他颜色（如tabbarItem会默认变蓝色）
        UIImage *homeSelectedImage = [[UIImage imageNamed:tabbarItemModel.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVc.tabBarItem.selectedImage = homeSelectedImage;
    }
    
    // 设置文字属性
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSForegroundColorAttributeName] = WJColor(123, 123, 123);
    NSMutableDictionary *selectTextAttri = [NSMutableDictionary dictionary];
    selectTextAttri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttri forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttri forState:UIControlStateSelected];
    
    // 先把传进来的小控制器包装到一个导航控制器中
    WJNavigationViewController *nav = [[WJNavigationViewController alloc] initWithRootViewController:childVc];
    
    // 添加一个子控制器
    [self addChildViewController:nav];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
