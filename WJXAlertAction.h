//
//  WJXAlertAction.h
//  Magic
//
//  Created by 王叔叔的MacBook Pro on 2018/3/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WJXAlertActionType) {
    WJXAlertActionTypeDefault = 0,     // 按钮
    WJXAlertActionTypeSheetCancel,     // 取消
};

@interface WJXAlertAction : NSObject

typedef void (^WJXAlertActionHandel)(WJXAlertAction *action);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) WJXAlertActionType style;
@property (nonatomic, strong) WJXAlertActionHandel handler;

/**
 添加按钮
 */
+ (WJXAlertAction *)actionWithTitle:(NSString *)title
                         textColor:(UIColor *)textColor
                             style:(WJXAlertActionType)style
                           handler:(void (^)(WJXAlertAction *action))handler;

@end
