  # WJXAlertView
    WJXAlertView

    版本1.0.1



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
                         
                         

