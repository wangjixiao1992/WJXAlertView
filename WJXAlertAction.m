//
//  WJXAlertAction.m
//  Magic
//
//  Created by 王叔叔的MacBook Pro on 2018/3/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WJXAlertAction.h"
#import "WJXAlertHeader.h"

@implementation WJXAlertAction

/**
 添加按钮
 */

+ (WJXAlertAction *)actionWithTitle:(NSString *)title
                         textColor:(UIColor *)textColor
                             style:(WJXAlertActionType)style
                           handler:(void (^)(WJXAlertAction *action))handler
{
    WJXAlertAction *action = [(WJXAlertAction *)[self alloc] init];
    action.title = title;
    action.textColor = textColor;
    action.style = style;
    action.handler = handler;
    return action;
}

@end
