//
//  AppDelegate.swift
//  HRWeChat
//
//  Created by obgniyum on 03/22/2018.
//  Copyright (c) 2018 obgniyum. All rights reserved.
//

import UIKit
import HRWeChat

/****************
 准备1:网络兼容HTTP
 ----------------
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 */


/***************
 准备2:URLTypes
 ---------------
 微信开放平台申请应用获得
 */
let WeChat_AppKey = "wxc76b0352eb334e37"
let WeChat_Secret = "aa899e5be0e49b698e00d29c2b9db917"


/***************
 准备3:App回调URLTypes
 ---------------
 - identifier = any string
 - URLSchemes = WeChat_AppKey(准备2获得)
 */


/***************
 准备4:App跳转白名单
 ---------------
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <string>weixin</string>
 <string>wechat</string>
 </array>
 */


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        WeChat.applicationDidFinish(appKey: WeChat_AppKey, sercet: WeChat_Secret)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        WeChat.applicationOpenURL(url:url)
        
        return true
    }
    


}

