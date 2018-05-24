//
//  WJXAlertViewCtl.h
//  Magic
//
//  Created by 王叔叔的MacBook Pro on 2018/3/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJXAlertAction.h"

typedef NS_ENUM(NSInteger, WJXAlertViewType) {
    WJXAlertViewTypeAlert = 0,       // 提示弹窗
    WJXAlertViewTypeSheet,           // 选择弹窗
};

@interface WJXAlertViewCtl : UIViewController

/**
 简单构造方法
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(WJXAlertViewType)preferredStyle;
/**
 设置富文本标题
 */
- (void)setTitleStringWithString:(NSAttributedString *)titleString;

/**
 设置富文本内容
 */
- (void)setContentStringWithString:(NSAttributedString *)contentString;

/**
 添加按钮
 */
- (void)addAction:(WJXAlertAction *)action;


@end
