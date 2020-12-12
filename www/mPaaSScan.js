var exec = require('cordova/exec');

exports.scan = function (options, success, error) {
    exec(success, error, 'mPaaSScan', 'standardScan', [options]);
};
