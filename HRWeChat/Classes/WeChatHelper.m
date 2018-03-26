//
//  E.m
//  HRWeChat
//
//  Created by Obgniyum on 2018/3/26.
//

#import "WeChatHelper.h"

@implementation WeChatHelper

+ (instancetype)allocWithZone:(NSZone *)zone{
    return [WeChatHelper shared];
}

+ (instancetype)shared{
    static WeChatHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    return [WeChatHelper shared];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone{
    return [WeChatHelper shared];
}


// MARK:-
- (void)openURL:(NSURL *)url {
    if ([url.scheme isEqualToString: self.appKey]) {
        [WXApi handleOpenURL:url delegate:self];
    }
}

// MARK:-
- (void)onResp:(BaseResp *)resp {
    
    if (self.method == WXMethodLogin) {
        SendAuthResp *rsp = (SendAuthResp *)resp;
        if ([rsp.state isEqualToString: kWeChatRequestState]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *urlString_auth = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", self.appKey, self.secret, rsp.code];
                NSURL *url_auth = [NSURL URLWithString:urlString_auth];
                NSData *data_auth = [NSData dataWithContentsOfURL:url_auth];
                NSDictionary *json_auth = [NSJSONSerialization JSONObjectWithData:data_auth options:NSJSONReadingAllowFragments error:nil];
                // access_token:获取用户信息
                NSString *access_token = json_auth[@"access_token"];
                // openid:唯一标识
                NSString *openid = json_auth[@"openid"];
                
                //            NSLog(@"access_token:%@", access_token);
                //            NSLog(@"openid:%@", openid);
                
                if (self.loginBlock) {
                    self.loginBlock(openid);
                }
            });
        }

    } else {
        if ([resp isKindOfClass:[PayResp class]]){
            PayResp *response=(PayResp *)resp;
            switch(response.errCode){
                case WXSuccess:
                    //服务器端查询支付通知或查询API返回的结果再提示成功
//                    NSLog(@"支付成功");
                    if (self.payBlock) {
                        self.payBlock(0);
                    }
                    break;
                default:
//                    NSLog(@"支付失败，retcode=%d",resp.errCode);
                    if (self.payBlock) {
                        self.payBlock(resp.errCode);
                    }
                    break;
            }
        }
    }
}

@end
