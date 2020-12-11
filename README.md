  # WJXAlertView
    
   ## 介绍
    此控件是自定义弹窗控件,只是为了项目需求,模仿苹果原生弹窗的弹窗视图,同样包含alert/sheet两种模式,只是为了统一弹窗!

   ## 版本
    1.0.1
    
   ## 版本
    source 'https://github.com/wangjixiao1992/WJXAlertView.git'
    platform :ios, '8.0'
    
    target 'TargetName' do
    pod 'WJXAlertView', '~> 1.0.1'
    end

   ## 演示代码
    //AlertView
    NSString *title = @"测试";
    NSString *content = @"正文";
    WJXAlertViewCtl *alert = [WJXAlertViewCtl alertControllerWithTitle:title
                                                               message:content
                                                        preferredStyle:WJXAlertViewTypeSheet];
            
    //确定
    WJXAlertAction *gotoAction = [WJXAlertAction actionWithTitle:@"确定"
                                                       textColor:[UIColor redColor]
                                                           style:WJXAlertActionTypeDefault
                                                         handler:^(WJXAlertAction *action) {
                         
                                                         }];
    [alert addAction:gotoAction];
                         
    //取消
    WJXAlertAction *cancenAction = [WJXAlertAction actionWithTitle:@"取消"
                                                         textColor:[UIColor redColor]
                                                             style:WJXAlertActionTypeSheetCancel
                                                           handler:^(WJXAlertAction *action) {
                         
                                                           }];
    [alert addAction:cancenAction];
                         
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
                         
    //Sheet
    NSString *title = @"测试";
    NSString *content = @"正文";
    WJXAlertViewCtl *alert = [WJXAlertViewCtl alertControllerWithTitle:nil
                                                               message:content
                                                        preferredStyle:WJXAlertViewTypeSheet];
                         
    //忽略
    WJXAlertAction *gotoAction = [WJXAlertAction actionWithTitle:@"确定"
                                                       textColor:[UIColor redColor]
                                                           style:WJXAlertActionTypeDefault
                                                         handler:^(WJXAlertAction *action) {
                         
                                                         }];
    [alert addAction:gotoAction];
                         
    //取消
    WJXAlertAction *cancenAction = [WJXAlertAction actionWithTitle:@"取消"
                                                         textColor:[UIColor redColor]
                                                             style:WJXAlertActionTypeSheetCancel
                                                           handler:^(WJXAlertAction *action) {
                         
                                                           }];
    [alert addAction:cancenAction];
                         
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
                         
   ## 联系我们
   如有疑问请发送邮件.谢谢~
   15037535383@163.com


