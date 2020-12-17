var fs = require('fs-extra');
var path = require('path');
var ios = require('./ios/iosAfterPluginInstall')


let copyIOSFramework = function()
{
    //platforms 平台下的android文件夹，一般为"CordovaRoot/platforms/ios"
    let iosPlatformDir=path.resolve(__dirname, '../../../platforms/ios');
    //插件所在的位置,一般为"CordovaRoot/plugins/mPaaSCore"
    let iosPluginDir=path.resolve(__dirname, '../src/ios');
    if(!fs.pathExistsSync(iosPlatformDir))
    {
        console.error("plugin not found the ios platform,and the mPaaS framework files will not be copy,until you added the ios platform,this plugin will copied automatically");
        return -1;
    }

    let mPaaSFrameworkPath=path.join(iosPluginDir,'MPaaS');

    try {
        fs.copySync(mPaaSFrameworkPath, path.join(iosPlatformDir,"MPaaS"))
        console.log('mpaas framework copy success!')
      } catch (err) {
        console.error("mpaas framework copy fail.error:"+err)
        return -1;
      }
    return 0;
}

// console.log('----------begin ios mPaaS Scan install----------')
// // let result2=copyIOSFramework();
// if(result2>=0)
// {
//     console.log('----------ios mPaaS Scan install done----------')
// }

ios.setPodfile();