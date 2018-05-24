//
//  WJXAlertViewCtl.m
//  Magic
//
//  Created by 王叔叔的MacBook Pro on 2018/3/21.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WJXAlertViewCtl.h"
#import "WJXAlertHeader.h"

#define kButtonHeight 60

typedef NS_ENUM(NSInteger, WJXAlertViewCtlAnimationStyle) {
    WJXAlertViewCtlAnimationStylePresenting,
    WJXAlertViewCtlAnimationStyleDismissing
};

@interface WJXAlertViewCtl ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) WJXAlertViewType alertType;
@property (nonatomic, copy)   NSString *alertTitle;
@property (nonatomic, copy)   NSString *alertContent;
@property (nonatomic, copy)   NSAttributedString *titleString;
@property (nonatomic, copy)   NSAttributedString *contentString;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end



#pragma mark - 转场
@interface WJXAlertViewCtlAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) WJXAlertViewCtlAnimationStyle animationStyle;
@end


@implementation WJXAlertViewCtlAnimationController
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.animationStyle == WJXAlertViewCtlAnimationStyleDismissing) {
        return 0.3f;
    }
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    if (self.animationStyle == WJXAlertViewCtlAnimationStylePresenting) {
        WJXAlertViewCtl *toVC = (WJXAlertViewCtl *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [containerView addSubview:toVC.view];
        
        // 马上布局,防止获取frame失败
        [toVC.view layoutIfNeeded];
        
        [UIView animateWithDuration:0.3
                              delay:0.1
             usingSpringWithDamping:1.0
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                                CGFloat height = toVC.backView.frame.size.height;
                                CGFloat width = toVC.backView.frame.size.width;
                                CGFloat x = toVC.backView.frame.origin.x;
                                if (toVC.alertType == WJXAlertViewTypeSheet) {
                                    toVC.backView.frame = CGRectMake(x , kscreenHeight - height, width, height);
                                } else {
                                    toVC.backView.frame = CGRectMake(x , (kscreenHeight - height) / 2, width, height);
                                }
                                [toVC.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                [transitionContext completeTransition:YES];
                            }];
    } else if (self.animationStyle == WJXAlertViewCtlAnimationStyleDismissing) {
        WJXAlertViewCtl *fromVC = (WJXAlertViewCtl *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [UIView animateWithDuration:0.3
                              delay:0.1
             usingSpringWithDamping:1.0
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             fromVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                             CGFloat height = fromVC.backView.frame.size.height;
                             CGFloat width = fromVC.backView.frame.size.width;
                             CGFloat x = fromVC.backView.frame.origin.x;
                             if (fromVC.alertType == WJXAlertViewTypeSheet) {
                                 fromVC.backView.frame = CGRectMake(x, kscreenHeight, width, height);
                             } else if (fromVC.alertType == WJXAlertViewTypeAlert) {
                                 fromVC.backView.frame = CGRectMake(x, kscreenHeight, width, height);
                             } else {
                                 fromVC.backView.frame = CGRectMake(x, - height, width, height);
                             }
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}
@end

@implementation WJXAlertViewCtl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom; // 自定义
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupUI];
}

/**
 构建UI
 */
- (void)setupUI
{
    [self.view addSubview:self.backView];
    
    if (self.alertType == WJXAlertViewTypeAlert) {
        [self.backView addSubview:self.alertView];
    } else {
        [self.backView addSubview:self.sheetView];
    }
}

#pragma mark -网络
/**
 简单构造方法
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(WJXAlertViewType)preferredStyle
{
    WJXAlertViewCtl *alert = [[WJXAlertViewCtl alloc] init];
    alert.alertTitle = title;
    alert.alertContent = message;
    alert.alertType = preferredStyle;
    return alert;
}

/**
 设置富文本标题
 */
- (void)setTitleStringWithString:(NSAttributedString *)titleString
{
    self.titleString = titleString;
}

/**
 设置富文本内容
 */
- (void)setContentStringWithString:(NSAttributedString *)contentString
{
    self.contentString = contentString;
}

/**
 添加按钮
 */
- (void)addAction:(WJXAlertAction *)action
{
    [self.dataSourceArray addObject:action];
}

/**
 按钮点击
 */
- (void)buttonClick:(UIButton *)sender
{
    WJXAlertAction *action = [self.dataSourceArray objectAtIndex:sender.tag - 1000];
    [self dismissViewControllerAnimated:YES completion:^{
        if (action.handler) {
            action.handler(action);
        }
    }];
}

- (void)dissMiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 构造按钮
 */
- (UIButton *)setButtonWithAction:(WJXAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:action.textColor
                 forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:action.title
            forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self
               action:@selector(buttonClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:button];
    return button;
}
#pragma mark - 懒加载
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return  _backView;
}

- (UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        CGFloat width = kscreenWidth - 80;
        _alertView.frame = CGRectMake(0, 0, width, 0);
        _alertView.backgroundColor = MALineColor;
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 10;
        
        UIView *titleView = [[UIView alloc] init];
        titleView.frame = CGRectMake(0, 0, width, 0);
        titleView.backgroundColor = [UIColor whiteColor];
        [_alertView addSubview:titleView];
        
        CGFloat offset = 0;
        if (self.alertTitle.length > 0 || self.titleString.length > 0) {
            UILabel *headerLabel = [[UILabel alloc] init];
            if (self.alertTitle.length > 0) {
                headerLabel.text = self.alertTitle;
            } else {
                headerLabel.attributedText = self.titleString;
            }
            headerLabel.textColor = MATitleColor;
            headerLabel.font = [UIFont systemFontOfSize:18];
            headerLabel.textAlignment = NSTextAlignmentCenter;
            headerLabel.backgroundColor = [UIColor whiteColor];
            if (self.alertContent.length > 0 || self.contentString.length > 0) {
                headerLabel.frame = CGRectMake(15, 0, width - 30, 50);
            } else {
                headerLabel.frame = CGRectMake(15, 0, width - 30, 80);
            }
            [titleView addSubview:headerLabel];
            titleView.frame = CGRectMake(0, 0, width, CGRectGetMaxY(headerLabel.frame));
            offset = CGRectGetMaxY(titleView.frame);
        }
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.clipsToBounds = YES;
        [titleView addSubview:scrollView];
        
        if (self.alertContent.length > 0 || self.contentString.length > 0) {
            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.backgroundColor = [UIColor whiteColor];
            [scrollView addSubview:contentLabel];
            
            CGFloat contentHeight = 0;
            if (self.alertContent.length > 0) {
                contentLabel.text = self.alertContent;
                contentHeight = [UILabel textHeightWithLabel:contentLabel
                                                 lineSpacing:3
                                                       width:width - 30];
            } else {
                contentLabel.attributedText = self.contentString;
                contentHeight = [UILabel attributedTextHeightWithLabel:contentLabel
                                                           lineSpacing:3
                                                                 width:width - 30];
            }
            contentLabel.textAlignment = NSTextAlignmentCenter;
            CGFloat contentOffsetY = 0;
            if (self.alertTitle.length > 0) {
                contentOffsetY = 25;
            } else {
                contentOffsetY = 50;
            }
            
            CGFloat scrollViewHeight = 0;
            if (contentHeight + contentOffsetY > kscreenHeight - knavHeight - ktabBarHeight - kButtonHeight * 2) {
                scrollViewHeight = kscreenHeight - knavHeight - ktabBarHeight - kButtonHeight * 2;
            } else {
                scrollViewHeight = contentHeight + contentOffsetY;
            }
            contentLabel.frame = CGRectMake(15, 0, width - 30, contentHeight + contentOffsetY);
            scrollView.frame = CGRectMake(0, offset, width, scrollViewHeight);
            scrollView.contentSize = CGSizeMake(width, contentHeight + contentOffsetY);
            titleView.frame = CGRectMake(0, 0, width, CGRectGetMaxY(scrollView.frame));
            offset = CGRectGetMaxY(titleView.frame);
        }
        
        if (self.dataSourceArray.count == 0) {
            WJXAlertAction *cancel = [WJXAlertAction actionWithTitle:@"取消"
                                                           textColor:[UIColor redColor]
                                                               style:WJXAlertActionTypeDefault
                                                             handler:^(WJXAlertAction *action) {
                                                                 
                                                             }];
            [self addAction:cancel];
        }
        
        CGFloat actionX = 0;
        CGFloat actionWith = width;
        if (self.dataSourceArray.count == 2) {
            actionWith = (width - MALineHeight)/ 2;
        }
        for (int i = 0; i < self.dataSourceArray.count; i++) {
            WJXAlertAction *action = [self.dataSourceArray objectAtIndex:i];
            UIButton *button = [self setButtonWithAction:action];
            button.tag = 1000 + i;
            button.frame = CGRectMake(actionX, offset + MALineHeight, actionWith, kButtonHeight);
            [_alertView addSubview:button];
            //计算下个按钮的位置
            CGFloat offsetX = CGRectGetMaxX(button.frame) + MALineHeight;
            if (offsetX >= width) {
                actionX = 0;
                offset = CGRectGetMaxY(button.frame);
            } else {
                actionX = offsetX;
            }
        }
        _alertView.frame = CGRectMake(0, 0, width, offset);
        self.backView.frame = CGRectMake((kscreenWidth - width) / 2, kscreenHeight, width, offset);
    }
    return  _alertView;
}

- (UIView *)sheetView
{
    if (!_sheetView) {
        _sheetView = [[UIView alloc] init];
        _sheetView.frame = CGRectMake(0, 0, kscreenWidth, 0);
        _sheetView.backgroundColor = MALineColor;
        
        CGFloat offset = 0;
        if (self.alertTitle.length > 0 || self.titleString.length > 0) {
            UILabel *headerLabel = [[UILabel alloc] init];
            if (self.alertTitle.length > 0) {
                headerLabel.text = self.alertTitle;
            } else {
                headerLabel.attributedText = self.titleString;
            }
            headerLabel.frame = CGRectMake(0, 0, kscreenWidth, 50);
            headerLabel.textColor = MATextColor;
            headerLabel.font = [UIFont systemFontOfSize:20];
            headerLabel.textAlignment = NSTextAlignmentCenter;
            headerLabel.backgroundColor = [UIColor whiteColor];
            [_sheetView addSubview:headerLabel];
            offset = CGRectGetMaxY(headerLabel.frame);
        }
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.clipsToBounds = YES;
        [_sheetView addSubview:scrollView];
        
        if (self.dataSourceArray.count == 0) {
            WJXAlertAction *cancel = [WJXAlertAction actionWithTitle:@"取消"
                                                           textColor:[UIColor redColor]
                                                               style:WJXAlertActionTypeSheetCancel
                                                             handler:^(WJXAlertAction *action) {
                                                                 
                                                             }];
            [self addAction:cancel];
        }
        
        CGFloat buttonY = 0;
        for (int i = 0; i < self.dataSourceArray.count; i++) {
            WJXAlertAction *action = [self.dataSourceArray objectAtIndex:i];
            UIButton *button = [self setButtonWithAction:action];
            button.tag = 1000 + i;
            if (action.style == WJXAlertActionTypeSheetCancel) {
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = MABackGroundCloor;
                line.frame = CGRectMake(0, buttonY, kscreenWidth, 10);
                [scrollView addSubview:line];
                button.frame = CGRectMake(0, buttonY + 10, kscreenWidth, kButtonHeight);
            } else {
                button.frame = CGRectMake(0, buttonY + MALineHeight, kscreenWidth, kButtonHeight);
            }
            [scrollView addSubview:button];
            buttonY = CGRectGetMaxY(button.frame);
            CGFloat scrollViewHeight = 0;
            if (buttonY > kscreenHeight - offset - knavHeight) {
                scrollViewHeight = kscreenHeight - offset - knavHeight;
            } else {
                scrollViewHeight = buttonY;
            }
            scrollView.frame = CGRectMake(0, offset, kscreenWidth, scrollViewHeight);
            scrollView.contentSize = CGSizeMake(kscreenWidth, buttonY);
        }
        
        offset = CGRectGetMaxY(scrollView.frame);
        _sheetView.frame = CGRectMake(0, 0, kscreenWidth, offset);
        self.backView.frame = CGRectMake(0, kscreenHeight, kscreenWidth, offset);
    }
    return  _sheetView;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    WJXAlertViewCtlAnimationController *animationController = [[WJXAlertViewCtlAnimationController alloc] init];
    animationController.animationStyle = WJXAlertViewCtlAnimationStylePresenting;
    
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    WJXAlertViewCtlAnimationController *animationController = [[WJXAlertViewCtlAnimationController alloc] init];
    animationController.animationStyle = WJXAlertViewCtlAnimationStyleDismissing;
    
    return animationController;
}

@end
