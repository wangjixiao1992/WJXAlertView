//
//  UIColor+alert.h
//  cocopods
//
//  Created by wangjixiao on 2018/5/18.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (alert)

/**
 颜色值
 
 @param hexValue   RGB
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue;


/**
 颜色值
 
 @param hexValue   RGB
 @param alphaValue 透明度
 */
+ (UIColor*)colorWithHex:(NSInteger)hexValue
                   alpha:(CGFloat)alphaValue;

@end
