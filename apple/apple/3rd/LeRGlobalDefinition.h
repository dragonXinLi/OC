//
//  LeRGlobalDefinition.h
//  apple
//
//  Created by sangfor on 17/4/1.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#ifndef LeRGlobalDefinition_h
#define LeRGlobalDefinition_h

#define STATUSBAR_SHIFT (20 * ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 1 : 0))
#define HEADVIEW_HEIGT (44 + STATUSBAR_SHIFT)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_FIXED_WIDTH (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define SCREEN_FIXED_HEIGHT (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

#define SCREEN_SCALE ([UIScreen mainScreen].scale)
#define UNIT_PIXEL (1/SCREEN_SCALE)

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#define weak(obj)  __weak typeof(obj) weak##obj = obj
#define strong(obj)   __strong typeof(obj) strong##obj = obj


#define TABLE_REFRESH_TIME [[FSFileOperation getDocumentDirectory] stringByAppendingPathComponent:@"five-TableRefreshTime.plist"]


//请求服务器是返回错误信息
#define kResultException	@"Unexpected result"
#define kResultInvalidArgs	@"Invalid Args"
#define kResultNetFailed	@"Net Failed"
#define kResultServerReject	@"Server Reject"
#define kResultUserDefine	@"User Define"
#define kResultServerError	@"Server Error"
#define kResultEncodeFailed	@"Encode Error"
#define kResultDecodeFailed	@"Decode Error"
#define kLoginFailed		kResultServerReject
#define kModelError			@"Model Error"
#define kUnknownError		@"Unknown Error"
#define kFileSystemError	@"File System Error"
#define kResultObjRegenFail	@"ResultObjRegenFail"
#define kResultServerVersionErr	@"kResultServerVersionErr"
#define kResultUserCancel   @"User Cancel"

#endif /* LeRGlobalDefinition_h */
