//
//  NSString+Extension.h
//  BGWeiBo
//
//  Created by fengwujie on 15/10/8.
//  Copyright © 2015年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  算出字符串的大小
 *
 *  @param font 字体
 *  @param maxW 最大宽度值
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *  算出字符串的大小
 *
 *  @param font 字体
 */
- (CGSize)sizeWithFont:(UIFont *)font;

@end
