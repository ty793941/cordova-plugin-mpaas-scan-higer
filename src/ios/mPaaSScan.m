/********* mPaaSScan.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "ViewController.h"


@interface mPaaSScan : CDVPlugin {
  // Member variables go here.
}

- (void)standardScan:(CDVInvokedUrlCommand*)command;
- (TBScanViewController *)setScanVCOptions:(NSDictionary*) echo withOptions:(TBScanViewController *) vc;
@property(nonatomic, strong) TBScanViewController *scanVC;
@end


@implementation mPaaSScan

- (void)standardScan:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* echo = [command.arguments objectAtIndex:0];

    [self custoDefaultScan:command.callbackId withOptions:echo];

}

- (void)custoDefaultScan:(NSString*)callbackId withOptions:(NSDictionary *) echo{
   TBScanViewController *vc = [[MPScanCodeAdapterInterface sharedInstance] createDefaultScanPageWithallback:^(id  _Nonnull result, BOOL keepAlive) {

       CDVPluginResult* pluginResult= [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result[@"resp_result"]];
       [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
       [self dismiss];
    }];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.viewController presentViewController:nav animated:NO completion:^{
    }];
    
    self.scanVC =  [self setScanVCOptions:echo withOptions:vc];
    
    
    

    
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
    vc.scanType =  ScanType_QRCode;
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
