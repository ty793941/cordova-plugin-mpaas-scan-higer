## mPaaS 

移动开发平台（Mobile PaaS，简称 mPaaS）是源于支付宝 App 的移动开发平台，为移动开发、测试、运营及运维提供云到端的一站式解决方案，能有效降低技术门槛、减少研发成本、提升开发效率，协助企业快速搭建稳定高质量的移动 App。

## 本插件
本插件集合了[阿里的移动开发平台mPaas](https://help.aliyun.com/document_detail/49549.html)中的标准UI扫一扫部分，安装本插件前请先安装[cordova-plugin-mPaaS-core-higer](https://github.com/ty793941/cordova-plugin-mPaaS-core-higer),否则会报依赖错误


## 使用

### 1.安装：
安装core插件，若已安装可忽略
> cordova plugins add cordova-plugin-mpaas-core-higer

安装scan插件 
> cordova plugin add cordova-plugin-mpaas-scan-higer

### 2. 复制config文件

#### 快速使用
>
    mPaaS.standardScan({
    }, (data:string) => {
      alert(data);
    });
>

#### 高级使用
>
    mPaaS.standardScan({
      scanType: 'QRCODE', // 判断扫码框，是QRCODE 还是BARCODE，默认QRCODE  --IOS不生效，只显示QRCODE
      titleText: 'titleText', // 设置扫码界面 title
      viewText: 'viewText', // 设置扫码窗口下提示文字      --IOS不显示
      openTorchText: 'openTorchText', // 设置打开手电筒提示文字，
      closeTorchText: 'closeTorchText', // 设置关闭手电筒提示文字，
      translucentStatusBar: true, // 设置透明状态栏       --IOS不生效
      notSupportAlbum: false, // 设置是否不支持相册，默认支持相册，false，
      recognize: 'QR_CODE,BAR_CODE'// 该设置仅对直接扫码生效，对识别相册图片无效。所有枚举：'QR_CODE,BAR_CODE,DM_CODE,PDF417_Code', 不设置，默认识别前三种     --IOS不支持配置，但是会支持过多
    }, (data:string) => {
      alert(data);// 成功处理
    }, (err:string) => {
      throw new Error(err); // 失败处理
    });
>

## 阶段
本插件尚处于内部测试阶段，若有兴趣的可以直接使用，但暂不可直接用于生产环境。



