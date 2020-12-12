var exec = require('cordova/exec');

exports.standardScan = function (options, success, error) {
    exec(success, error, 'mPaaSScan', 'standardScan', [options]);
};
