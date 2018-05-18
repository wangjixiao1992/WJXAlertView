//
//  UILabel+alert.m
//  cocopods
//
//  Created by wangjixiao on 2018/5/18.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import "UILabel+alert.h"

@implementation UILabel (alert)

/**
 *  设置行间距 根据已有的text
 *
 *  @param label       空间
 *  @param lineSpacing 行距
 *  @param width       宽度
 *
 *  @return 高度
 */
+ (CGFloat)textHeightWithLabel:(UILabel *)label
                   lineSpacing:(CGFloat)lineSpacing
                         width:(CGFloat)width
{
    if (label.text.length > 0) {
        label.frame = CGRectMake(0, 0, width, 0);
        NSDictionary *attribute = @{NSFontAttributeName:label.font};
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text
                                                                                              attributes:attribute];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpacing;
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0, [label.text length])];
        label.numberOfLines = 0;
        label.attributedText = attributedString;
        [label sizeToFit];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        return label.frame.size.height;
    } else {
        return 0;
    }
}


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
                                   width:(CGFloat)width
{
    if (label.text.length > 0) {
        label.frame = CGRectMake(0, 0, width, 0);
        label.numberOfLines = 0;
        NSMutableAttributedString *attributedString = [label.attributedText mutableCopy];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpacing;
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0, [label.text length])];
        label.attributedText = attributedString;
        [label sizeToFit];
        return label.frame.size.height;
    } else {
        return 0;
    }
}

@end
