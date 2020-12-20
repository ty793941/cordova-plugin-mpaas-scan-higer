var podfile=require('./ios/podfileOperate')
var iosConfig=require('./ios/configOperate')

iosConfig.checkAndCopyIOSConfig();
podfile.setPodfile();
