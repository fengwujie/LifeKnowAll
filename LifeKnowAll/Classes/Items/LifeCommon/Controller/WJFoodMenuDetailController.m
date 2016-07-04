//
//  WJFoodMenuDetailController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/12.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuDetailController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "WJMethod.h"

#define lableFont [UIFont systemFontOfSize:16]
#define margin 5

@interface WJFoodMenuDetailController ()

@property (nonatomic, strong) UIView *sv;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lastView;

@end

@implementation WJFoodMenuDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化UI控件
 */
- (void) setup{
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    //大图预览
    if (self.food.recipe.img) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        //imgView.backgroundColor =WJRandomColor;
        [self.scrollView addSubview:imgView];
        UIImage *image = [self getImageWithUrl:self.food.recipe.img];
        imgView.image = image;
        CGSize size = [self getSizeWithImage:image];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.top.mas_equalTo(self.scrollView.mas_top).offset(margin);
            make.centerX.mas_equalTo(self.scrollView.centerX);
        }];
        self.lastView = imgView;
    }
    
    //综述
    if (self.food.recipe.sumary && self.food.recipe.sumary.length>0) {
        //综述内容
        UILabel *sumaryLable = [[UILabel alloc] init];
        [self.scrollView addSubview:sumaryLable];
        NSString *sumary = [NSString stringWithFormat:@"简介：%@",self.food.recipe.sumary] ;
        //NSString *sumary = self.food.recipe.sumary ;
        sumaryLable.text = sumary;
        //sumaryLable.backgroundColor = WJRandomColor;
        sumaryLable.textAlignment = NSTextAlignmentLeft;
        sumaryLable.font = lableFont;
        sumaryLable.numberOfLines = 0;
        //        CGSize size = [sumary sizeWithFont:lableFont maxW:screenW - margin * 3];
        [sumaryLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(self.view).offset(-margin);
            
            if (self.lastView) {
                make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(margin);
            }
            
        }];
        self.lastView = sumaryLable;
    }
    
    /*//标签分类
    if (self.food.ctgTitles) {
        UILabel *ctgTitlesLable = [[UILabel alloc] init];
        [self.scrollView addSubview:ctgTitlesLable];
        NSString *ctgTitles = [NSString stringWithFormat:@"标签分类：%@",self.food.ctgTitles] ;
        //NSString *sumary = self.food.recipe.sumary ;
        ctgTitlesLable.text = ctgTitles;
        //ctgTitlesLable.backgroundColor = WJRandomColor;
        ctgTitlesLable.textAlignment = NSTextAlignmentLeft;
        ctgTitlesLable.font = lableFont;
        ctgTitlesLable.numberOfLines = 0;
        //        CGSize size = [ctgTitles sizeWithFont:lableFont maxW:screenW - margin * 3];
        [ctgTitlesLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(self.view).offset(-margin);
            
            if (self.lastView) {
                make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(margin);
            }
        }];
        self.lastView = ctgTitlesLable;
    }
     */
    
    //成分
    if (self.food.recipe.ingredients) {
        UILabel *ingredientsLable = [[UILabel alloc] init];
        [self.scrollView addSubview:ingredientsLable];
        NSString *ingredients = [NSString stringWithFormat:@"成分：%@",self.food.recipe.ingredients] ;
        //NSString *sumary = self.food.recipe.sumary ;
        ingredientsLable.text = ingredients;
        //ingredientsLable.backgroundColor = WJRandomColor;
        ingredientsLable.textAlignment = NSTextAlignmentLeft;
        ingredientsLable.font = lableFont;
        ingredientsLable.numberOfLines = 0;
        //        CGSize size = [ingredients sizeWithFont:lableFont maxW:screenW - margin * 3];
        [ingredientsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(self.view).offset(-margin);
            
            if (self.lastView) {
                make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(margin);
            }
        }];
        self.lastView = ingredientsLable;
    }
    
    //如何制作标题
    if (self.food.recipe.title) {
        UILabel *titleLable = [[UILabel alloc] init];
        [self.scrollView addSubview:titleLable];
        //NSString *title = [NSString stringWithFormat:@"标签分类：%@",self.food.ctgTitles] ;
        NSString *title = self.food.recipe.title ;
        titleLable.text = title;
        //titleLable.backgroundColor = WJRandomColor;
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.textColor = [UIColor blackColor];
        titleLable.font =[UIFont boldSystemFontOfSize:20]; // lableFont;
        titleLable.numberOfLines = 0;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.right.mas_equalTo(self.view).offset(-margin);
            
            if (self.lastView) {
                make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(margin);
            }
            
        }];
        self.lastView = titleLable;
    }

    
    //制作步骤：
    if (self.food.recipe.method) {
        for (WJMethod *method in self.food.recipe.method) {
            if (method.step && method.step.length>0) {
                UILabel *stepLable = [[UILabel alloc] init];
                [self.scrollView addSubview:stepLable];
                NSString *step = method.step ;
                stepLable.text = step;
                //stepLable.backgroundColor = WJRandomColor;
                stepLable.textAlignment = NSTextAlignmentLeft;
                stepLable.font = lableFont;
                stepLable.numberOfLines = 0;
                [stepLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(margin);
                    make.right.mas_equalTo(self.view).offset(-margin);
                    
                    if (self.lastView) {
                        make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
                    } else {
                        make.top.mas_equalTo(self.scrollView).offset(margin);
                    }
                }];
                self.lastView = stepLable;
            }
            
            if (method.img) {
                UIImageView *imgView = [[UIImageView alloc] init];
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                //imgView.backgroundColor =WJRandomColor;
                [self.scrollView addSubview:imgView];
                UIImage *image = [self getImageWithUrl:method.img];
                imgView.image = image;
                CGSize size = [self getSizeWithImage:image];
                [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(size);
                    if (self.lastView) {
                        make.top.mas_equalTo(self.lastView.mas_bottom).offset(margin);
                    }
                    else{
                        make.top.mas_equalTo(self.scrollView.mas_top).offset(margin);
                    }
                    make.centerX.mas_equalTo(self.scrollView.centerX);
                }];
                self.lastView = imgView;
            }
        }
    }

/*
    for (NSUInteger i = 0; i < 20; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.layer.borderWidth = 2.0;
        label.text = [self randomText];
        
        // We must preferredMaxLayoutWidth property for adapting to iOS6.0
        label.preferredMaxLayoutWidth = screenWidth - 30;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [self randomColor];
        [self.scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(20);
            }
        }];
        
        lastLabel = label;
    }
    */
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(self.lastView.mas_bottom).offset(margin);
    }];
}

/**
 *  根据URL链接获取IMAGE
 */
-(UIImage *)getImageWithUrl:(NSString *) strUrl
{
    NSURL *url = [NSURL URLWithString: strUrl];
    return [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
}
/**
 *  根据image获取对应size，如果宽度超过屏幕宽度的话，会按比较缩小
 */
-(CGSize)getSizeWithImage:(UIImage *)image
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width - margin * 2;
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    if (image.size.width > screenW) {
        imgW = screenW;
        imgH = screenW * image.size.height / image.size.width;
    }
    return CGSizeMake(imgW, imgH);
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
