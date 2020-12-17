//
//  MPScanDemoVC.m
//  MPScanDemo
//
//  Created by shifei.wkp on 2018/12/18.
//  Copyright © 2018 alipay. All rights reserved.
//

#import "ViewController.h"
#import "MPScanCodeViewController.h"


@interface ViewController()<TBScanViewControllerDelegate>
@property(nonatomic, strong) TBScanViewController *scanVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 150, 200, 33);
    [btn1 setTitle:@"全屏扫码页面" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(fullScan) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 200, 33);
    [btn2 setTitle:@"默认样式扫码页面" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(defaultScan) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 250, 200, 33);
    [btn3 setTitle:@"自定义扫码页面" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(customScan) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];

}

- (void)fullScan {
    TBScanViewController *vc = [TBScanViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)defaultScan {
    MPScanCodeViewController *vc = [[MPScanCodeViewController alloc] init];
    vc.usingDefaultStyle = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customScan {
    MPScanCodeViewController *vc = [[MPScanCodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
