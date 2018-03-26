//
//  HRWX.swift
//  Pods-HRWeChat_Example
//
//  Created by Obgniyum on 2018/3/26.
//

import UIKit

public typealias StringBlock = (String?)->()
public typealias ResultBlock = (Int)->()

public class WeChat: NSObject {
    
    static var manager = WeChatHelper()
    
    //MARK:- App CFG
    // c-注册
    public class func applicationDidFinish(appKey:String, sercet:String) {
        manager.appKey = appKey
        manager.secret = sercet
        WXApi.registerApp(appKey)
    }
    // c-统一回调处理
    public class func applicationOpenURL(url:URL) {
        manager.open(url);
    }
    
    //MARK:- Common API
    // c-是否安装
    public class func isInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    
    //MARK:- Login API
    // l-登录（请求授权信息）
    public class func login(complete:@escaping StringBlock) {
        manager.method = .login
        manager.loginBlock = complete
        let req = SendAuthReq()
        req.scope = kWechatScopeUserInfo
        req.state = kWeChatRequestState
        WXApi.send(req)
    }
    
    
    //MARK:- Pay API
    // p-支付
    /*
     00 - 成功 - 展示成功页面
     -1 - 错误 - 可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
     -2 - 用户取消 - 无需处理。发生场景：用户不支付了，点击取消，返回APP。
     */
    public class func pay(config:((PayReq)->()), complete:@escaping ResultBlock) {
        manager.method = .pay
        manager.payBlock = complete
        let pay = PayReq()
        config(pay)
        WXApi.send(pay)
    }
    
}
