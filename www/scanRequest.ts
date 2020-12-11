export interface ScanRequest
{
    mRecognizeTypes:string;
    mScanType:ScanType;
    mSourceId :string;
    mDataType:string;
    mCallBackUrl:string;
    mViewText:string;
    mExtra:string;
    mActionText:string;
    mActionUrl:string;
    mTitleText:string;
    mActionConfig:string;
    mNotSupportAlbum:boolean;
    mObjectCharset:string;
    mOpenTorchText:string;
    mCloseTorchText:string;
    translucentStatusBar:boolean;
}


export enum ScanType {
    DEFAULT,
    BARCODE,
    QRCODE,
    LOTTERY
}