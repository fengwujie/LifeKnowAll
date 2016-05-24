//
//  WJBaseItemViewController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJBaseItemViewController.h"
#import "WJBaseCollectionViewCell.h"
#import "WJGridModel.h"

#define kMargin 5   //设置GRID网格的间距

@interface WJBaseItemViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

static NSString *cellID = @"gridCell";
@implementation WJBaseItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //[_collectionView setBackgroundColor:WJRandomColor];
        
        //注册Cell，必须要有
        //[_collectionView registerClass:[WJBaseCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WJBaseCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDataSource
/**
 *  数据组数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/**
 *  每组数据的个数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayGridModel.count;
}
/**
 *  设置每个CELL的内容
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJBaseCollectionViewCell *cell = (WJBaseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.gridModel = _arrayGridModel[indexPath.row];
    cell.backgroundColor = WJRandomColor;
    return cell;
}
#pragma UICollectionViewDelegate
/**
 *  CELL选中事件
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGridModel *gridModel = [self.arrayGridModel objectAtIndex:indexPath.row];
    UIViewController *childVc = (UIViewController *)[[NSClassFromString(gridModel.controllerView) alloc] init];
    childVc.title = gridModel.gridTitle;
    //childVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:childVc animated:YES];
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //GIRD单元格的宽度 = (collectionView.width - kMargin * (kRowCount + 1))/kRowCount
    CGFloat cellWidth = (collectionView.width - kMargin * (self.iCellCount + 1)) * 1.0 / self.iCellCount;
    return CGSizeMake(cellWidth, cellWidth);
}

//设置Cell的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}

@end
