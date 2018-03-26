//
//  E.h
//  HRWeChat
//
//  Created by Obgniyum on 2018/3/26.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef NS_ENUM(NSUInteger, WXMethod) {
    WXMethodLogin,
    WXMethodPay
};

static NSString *kWechatScopeUserInfo = @"snsapi_userinfo";
static NSString *kWeChatRequestState = @"com.lengzhuo.xybh.wx.req.state";

@interface WeChatHelper : NSObject <WXApiDelegate>

@property(nonatomic, copy) NSString *appKey;
@property(nonatomic, copy) NSString *secret;

@property (nonatomic, assign) WXMethod method;

@property (nonatomic, copy) void(^loginBlock)(NSString *openid);
@property (nonatomic, copy) void(^payBlock)(NSInteger);

- (void)openURL:(NSURL *)url;


@end
