var exec = require('cordova/exec');

exports.standardScan = function (arg0, success, error) {
    exec(success, error, 'mPaaSScan', 'standardScan', [arg0]);
};
