//
//  UILabel+alert.h
//  cocopods
//
//  Created by wangjixiao on 2018/5/18.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (alert)

/**
 *  设置行间距 根据已有的text
 *
 *  @param label       控件
 *  @param lineSpacing 行距
 *  @param width       宽度
 *
 *  @return 高度
 */
+ (CGFloat)textHeightWithLabel:(UILabel *)label
                   lineSpacing:(CGFloat)lineSpacing
                         width:(CGFloat)width;

/**
 *  设置行间距 根据已有的attributedText
 *
 *  @param label       控件
 *  @param lineSpacing 行距
 *  @param width       宽度
 *
 *  @return 高度
 */
+ (CGFloat)attributedTextHeightWithLabel:(UILabel *)label
                             lineSpacing:(CGFloat)lineSpacing
                                   width:(CGFloat)width;

@end
