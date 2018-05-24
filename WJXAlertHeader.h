//
//  Header.h
//  cocopods
//
//  Created by wangjixiao on 2018/5/18.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#ifndef WJXAlertHeader_h
#define WJXAlertHeader_h

#import "UILabel+alert.h"
#import "UIColor+alert.h"

#pragma mark --  尺寸配置
#define  kscreenWidth      [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define  kscreenHeight     [UIScreen mainScreen].bounds.size.height //屏幕长度
#define  kscProportion     (kscreenHeight / kscreenWidth >= 2436.0 / 1125.0) ? 1 : 0
#define  knavHeight        ((kscProportion == 1) ? 88 : 64)   //屏幕宽度
#define  ktabBarHeight     ((kscProportion == 1) ? 83 : 49)   //屏幕宽度

#define  kTitleColor      [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0f]
#define  kTextColor       [UIColor colorWithRed:136.0 / 255.0 green:136.0 / 255.0 blue:136.0 / 255.0 alpha:1.0f]
#define  kOrangeColor     [UIColor colorWithRed:255.0 / 255.0 green:198.0 / 255.0 blue:1.0 / 255.0 alpha:1.0f]
#define  kLineColor       [UIColor colorWithRed:229.0 / 255.0 green:229.0 / 255.0 blue:229.0 / 255.0 alpha:1.0]
#define  kLineHeight      1
#define  kBackGroundCloor [UIColor colorWithHex:0xefefef]



#endif /* WJXAlertHeader_h */
