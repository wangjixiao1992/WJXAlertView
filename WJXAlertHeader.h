//
//  Header.h
//  cocopods
//
//  Created by wangjixiao on 2018/5/18.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#ifndef WJXAlertHeader_h
#define WJXAlertHeader_h

#import "UIColor+alert.h"
#import "UILabel+alert.h"

#pragma mark --  尺寸配置
#define  kscreenWidth   [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define  kscreenHeight  [UIScreen mainScreen].bounds.size.height //屏幕长度
#define  kscProportion  (kscreenHeight / kscreenWidth >= 2436.0 / 1125.0) ? 1 : 0
#define  knavHeight     ((kscProportion == 1) ? 88 : 64)   //屏幕宽度
#define  ktabBarHeight  ((kscProportion == 1) ? 83 : 49)   //屏幕宽度

#define MANavColor        [UIColor blackColor]                                                      //导航炫彩
#define MAMainColor       [UIColor colorWithHex:0xf25050]                                           //主色调
#define MATitleColor      [UIColor colorWithHex:0x434343]                                           //标题颜色
#define MATextColor       [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0] //文本颜色
#define MALineColor       [UIColor colorWithHex:0xc5c5c5]                                           //分割线颜色
#define MALineHeight      0.6                                                                       //分割线高度
#define MABackGroundCloor [UIColor colorWithHex:0xefefef]                                           //背景色
#define MAAlphaBackColor  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3]


#endif /* WJXAlertHeader_h */
