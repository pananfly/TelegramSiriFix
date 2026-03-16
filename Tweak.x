#import <UIKit/UIKit.h>

/**
 * 拦截 Intents 框架的偏好设置类
 * 当 App 尝试调用 sharedPreferences 时，系统会检查 Siri Entitlement。
 * 通过返回 nil，我们可以绕过这个检查，防止因缺少权限导致的 crash。
 */

%hook INPreferences
+ (id)sharedPreferences {
    return nil;
}
- (void)requestSiriAuthorization:(void(^)(long long status))handler {
    if (handler) handler(0); // 返回未确定状态
}
%end

%hook INVoiceShortcutCenter
+ (id)sharedCenter {
    return nil;
}
%end

%ctor {
    NSLog(@"[SiriFix] Tweak loaded - Suppressing SiriKit calls.");
    %init;
}
