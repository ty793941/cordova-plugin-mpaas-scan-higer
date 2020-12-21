/********* mPaaSScan.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>


@interface mPaaSScan : CDVPlugin {
  // Member variables go here.
}
//标准UI 扫码
- (void)standardScan:(CDVInvokedUrlCommand*)command;

@property(nonatomic, strong) TBScanViewController *scanVC;
@end


@implementation mPaaSScan

//标准UI 扫码
- (void)standardScan:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* echo = [command.arguments objectAtIndex:0];
    // 唤醒默认扫码ui
    [self custoDefaultScan:command.callbackId withOptions:echo];

}
// 唤醒默认扫码ui
- (void)custoDefaultScan:(NSString*)callbackId withOptions:(NSDictionary *) echo{
   TBScanViewController *vc = [[MPScanCodeAdapterInterface sharedInstance] createDefaultScanPageWithallback:^(id  _Nonnull result, BOOL keepAlive) {
       //TODO 判断返回结果
       NSString *res=result[@"resp_code"];
       CDVPluginResult* pluginResult= nil;
       if([res isEqual:@"1000"])
       {
           //扫码成功回调
           pluginResult= [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result[@"resp_result"]];
       }
       else
       {
           pluginResult= [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"fail"];
       }
       //关闭扫码窗口
       [[self.scanVC presentingViewController] dismissViewControllerAnimated:NO completion:^{
           //返回结果
           [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
       }];
    }];

    //扫码窗口，增加导航条
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationCurrentContext;//全屏
    //呈现扫码界面
    [self.viewController presentViewController:nav animated:NO completion:^{
    }];
    
    //设置扫码属性
    self.scanVC =  [self setScanVCOptions:echo withOptions:vc];
    
    //原扫码ui 在导航左边增加关闭按钮
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}
- (void)selectPhotos
{
    [self.scanVC scanPhotoLibrary];
}

-(void)dismiss
{
    [[self.scanVC presentingViewController] dismissViewControllerAnimated:NO completion:^{}];
}

-(TBScanViewController *)setScanVCOptions:(NSDictionary*) echo withOptions:(TBScanViewController *) vc{
    
    //设置默认值
    // 设置扫码界面 title
    vc.title = @"标准扫码";
    // 设置打开手电筒提示文字
    vc.torchStateNormalTitle = @"打开手电筒";
    // 设置关闭手电筒提示文字
    vc.torchStateSelectedTitle = @"关闭手电筒";
    // 设置扫码识别类型
    vc.scanType =  ScanType_ALIPAY_Code;
    // 设置选择相册按钮
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(selectPhotos)];
    
    NSString *scanType = [echo objectForKey:@"scanType"];
    if(![self isBlankString:scanType])
    {
        //do nothing
    }
    NSString *titleText = [echo objectForKey:@"titleText"];
    if(![self isBlankString:titleText])
    {
        vc.title=titleText;
    }
    NSString *viewText = [echo objectForKey:@"viewText"];
    if(![self isBlankString:viewText])
    {
        //do nothing
    }
    NSString *openTorchText = [echo objectForKey:@"openTorchText"];
    if(![self isBlankString:openTorchText])
    {
        vc.torchStateNormalTitle =openTorchText;
    }
    NSString *closeTorchText = [echo objectForKey:@"closeTorchText"];
    if(![self isBlankString:closeTorchText])
    {
        vc.torchStateSelectedTitle =closeTorchText;
    }
    bool translucentStatusBar = [[echo objectForKey:@"translucentStatusBar"] boolValue];
    if(translucentStatusBar)
    {
        //do nothing
    }
    bool notSupportAlbum = [[echo objectForKey:@"notSupportAlbum"] boolValue];
    if(notSupportAlbum)
    {
        vc.navigationItem.rightBarButtonItem=nil;
    }
    NSString *recognize = [echo objectForKey:@"recognize"];
    if(![self isBlankString:recognize])
    {
        //do nothing
    }

    //todo 由于目前相册选取图片在回调的时候sendPluginResult会卡死，暂未找到原因，所以先注释掉了。
    vc.navigationItem.rightBarButtonItem=nil;
    return vc;
}

- (BOOL) isBlankString:(NSString *)string {//判断字符串是否为空 方法

    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
