package higer.plugin.mpaas.scan;

import android.content.Intent;
import android.text.TextUtils;

import com.alipay.android.phone.scancode.export.ScanCallback;
import com.alipay.android.phone.scancode.export.ScanRequest;
import com.alipay.android.phone.scancode.export.adapter.MPScan;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * This class echoes a string called from JavaScript.
 */
public class scan extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("standardScan")) {
            JSONObject options = args.getJSONObject(0);
            this.standardScan(options, callbackContext);
            return true;
        }
        return false;
    }

    private void standardScan(JSONObject options,CallbackContext callbackContext) throws JSONException {
        this.scan(options,callbackContext);
    }

    private void scan(JSONObject options,CallbackContext callbackContext) throws JSONException {
        ScanRequest scanRequest = getScanRequest(options);

        MPScan.startMPaasScanActivity(cordova.getActivity(), scanRequest, new ScanCallback() {
            @Override
            public void onScanResult(final boolean isProcessed, final Intent result) {
                if (!isProcessed) {
                    // 扫码界面点击物理返回键或左上角返回键
                    return;
                }
                // 注意：本回调是在子线程中执行
               cordova.getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (result == null || result.getData() == null) {
                            // 扫码失败
                            callbackContext.error("failed");
                            return;
                        }
                        // 扫码成功
                        String url = result.getData().toString();
                        callbackContext.success(url);
                    }
                });
            }
        });
    }

    private ScanRequest getScanRequest(JSONObject options)throws JSONException
    {
        ScanRequest scanRequest = new ScanRequest();

        scanRequest.setScanType(ScanRequest.ScanType.QRCODE);
        //判断扫码框，是QRCODE 还是BARCODE，默认QRCODE
        if (options.has("scanType")) {
            String type = options.getString("scanType");
            if (!TextUtils.isEmpty(type)) {
                if (ScanRequest.ScanType.BARCODE.name().equals(type)) {
                    scanRequest.setScanType(ScanRequest.ScanType.BARCODE);
                }

                if (ScanRequest.ScanType.QRCODE.name().equals(type)) {
                    scanRequest.setScanType(ScanRequest.ScanType.QRCODE);
                }
            }
        }


        // 设置扫码界面 title
        if (options.has("titleText")) {
            String text = options.getString("titleText");
            scanRequest.setTitleText(text);
        }

        // 设置扫码窗口下提示文字
        if (options.has("viewText")) {
            String text = options.getString("viewText");
            scanRequest.setViewText(text);
        }

        // 设置打开手电筒提示文字，
        if (options.has("openTorchText")) {
            String text = options.getString("openTorchText");
            scanRequest.setOpenTorchText(text);
        }

        // 设置关闭手电筒提示文字，
        if (options.has("closeTorchText")) {
            String text = options.getString("closeTorchText");
            scanRequest.setCloseTorchText(text);
        }

        // 设置透明状态栏
        if (options.has("translucentStatusBar")) {
            boolean translucentStatusBar = options.getBoolean("translucentStatusBar");
            scanRequest.setTranslucentStatusBar(translucentStatusBar);
        }

        //设置是否不支持相册，默认支持相册，false，
        boolean notSupportAlbum;
        if (options.has("notSupportAlbum")) {
            notSupportAlbum = options.getBoolean("notSupportAlbum");
            scanRequest.setNotSupportAlbum(notSupportAlbum);
        }

        // 该设置仅对直接扫码生效，对识别相册图片无效, 不设置，默认识别前三种QR_CODE、BAR_CODE、DM_CODE
        boolean hasSetRecognizeType = false;
        if (options.has("recognize")) {
            String recognizeTypes = options.getString("recognize");
            ArrayList<ScanRequest.RecognizeType> recognizeTypes2 = new ArrayList();

            String[] recognizeArray =   recognizeTypes.split(",");
            for (String r:recognizeArray
            ) {
                if (ScanRequest.RecognizeType.QR_CODE.name().equals(r)) {
                    recognizeTypes2.add(ScanRequest.RecognizeType.QR_CODE);
                }
                if (ScanRequest.RecognizeType.BAR_CODE.name().equals(r)) {
                    recognizeTypes2.add(ScanRequest.RecognizeType.BAR_CODE);
                }

                if (ScanRequest.RecognizeType.DM_CODE.name().equals(r)) {
                    recognizeTypes2.add(ScanRequest.RecognizeType.DM_CODE);
                }

                if (ScanRequest.RecognizeType.PDF417_Code.name().equals(r)) {
                    recognizeTypes2.add(ScanRequest.RecognizeType.PDF417_Code);
                }
            }
            if (recognizeTypes2.size() > 0) {
                hasSetRecognizeType = true;
                scanRequest.setRecognizeType((ScanRequest.RecognizeType[])recognizeTypes2.toArray(new ScanRequest.RecognizeType[recognizeTypes2.size()]));
            }
        }
        if (!hasSetRecognizeType) {
            scanRequest.setRecognizeType(new ScanRequest.RecognizeType[]{ScanRequest.RecognizeType.BAR_CODE, ScanRequest.RecognizeType.QR_CODE});
        }

        return scanRequest;

    }

}
