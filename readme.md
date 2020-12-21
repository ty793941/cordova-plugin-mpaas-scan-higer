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

## 热点问题
#### 1.plugin 安装时 pod install 时出错，只有返回错误代码1提示
    可以在控制台切换到ios目录，然后手工执行sudo pod install可以看到详细错误信息。

#### 2.ios add plugin时 提示找不到配置文件，但是明明已经复制到ios根目录了。
    文件名称大小写问题，把文件名中到ios改为iOS,如Ant-mpaas-xxxxxxxxx-default-ios.config 改为 Ant-mpaas-xxxxxxxxx-default-iOS.config。
    
    为什么不系统处理了？原因是在官网download的时候文件名就是ios，但是在阿里源码读取的时候又要求iOS，我觉得这可能是阿里的一个bug，届时可能会进行修复。我们这边如果做了处理，把ios转成iOS，那么阿里那边的修复方式，我们是未知的，都有再次动代码的风险。但是他们最终肯定是要下载与读取的大小写一致的，也就是我们目前的代码是与他们最终目标是一致的，所以此处系统不做处理。

#### 3.在打开摄像头/相册的时候，系统闪退。
    请检查是否填写了摄像头/相册的权限说明。  
    ><config-file target="*-Info.plist" parent="NSCameraUsageDescription">
             <string>请填写自己的摄像头权限说明</string>
         </config-file>

    <config-file target="*-Info.plist" parent="NSPhotoLibraryUsageDescription">
        <string>请填写自己的相册权限说明</string>
    </config-file>
    >
#### 4.卸载cordova-plugin-mpaas-scan-higer时，有pod 报错。
  方法1:再卸载cordova-plugin-mpaas-core-higer，再次一起安装，先装core，再装scan
  方法2:platform remove ios 后，再add 进去
  >sudo cordova platform remove ios
  >sudo cordova platform add ios

## 阶段
本插件尚处于内部测试阶段，若有兴趣的可以直接使用，但暂不可直接用于生产环境。



