var fs = require('fs-extra');
var path = require('path');



let removeIOSFramework = function()
{
    //platforms 平台下的android文件夹，一般为"CordovaRoot/platforms/ios"
    let iosPlatformDir=path.resolve(__dirname, '../../../platforms/ios');

    if(!fs.pathExistsSync(iosPlatformDir))
    {
        console.error("not found the mpaas folder,please remove the folder manually");
        return -1;
    }

    try {
        fs.removeSync(path.join(iosPlatformDir,"MPaaS"));
        console.log('mpaas framework remove success!')
      } catch (err) {
        console.error("mpaas framework remove fail.error:"+err)
        return -1;
      }
    return 0;
}

console.log('----------begin ios mPaaS Scan remove----------')
let result2=removeIOSFramework();
if(result2>=0)
{
    console.log('----------ios mPaaS Scan remove done----------')
}