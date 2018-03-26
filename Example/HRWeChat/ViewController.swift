//
//  ViewController.swift
//  HRWeChat
//
//  Created by obgniyum on 03/22/2018.
//  Copyright (c) 2018 obgniyum. All rights reserved.
//

import UIKit
import HRWeChat


class ViewController: UIViewController {
    
    @IBOutlet weak var authBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        authBtn.isHidden = !WeChat.isInstalled()
        payBtn.isHidden = !WeChat.isInstalled()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-
    // auth
    @IBAction func authAction(_ sender: Any) {
        WeChat.login { openid in
            print("openid=" + openid!)
        }
    }
    
    @IBAction func payAction(_ sender: Any) {
        WeChat.pay(config: { (req) in
            
            req.partnerId = "1499698102";
            req.prepayId = "wx2018032614545188b110c8a40088988056";
            req.package = "Sign=WXPay";
            req.nonceStr = "546797";
            req.timeStamp = 1522046439;
            req.sign = "9FEC306F6E92BADC93AA952FD6739060";
            
        }) { (res) in
            switch res {
            case 0: do {
                print("支付成功")
                }
            case -1: do {
                //开发失败可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                print("配置错误")
                }
            case -2: do {
                //无需处理。发生场景：用户不支付了，点击取消，返回APP。
                print("业务错误")
                }
            default: do {
                print("未知错误")
                }
            }
        }
    }
}

