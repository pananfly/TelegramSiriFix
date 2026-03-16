#import <UIKit/UIKit.h>
#import <dlfcn.h>

// 1. 核心防御：直接拦截 INPreferences 初始化
%hook INPreferences
+ (id)sharedPreferences {
    NSLog(@"[SiriFix] Blocked INPreferences sharedPreferences");
    return nil; 
}
%end

// 2. 拦截系统权限弹窗
%hook UNUserNotificationCenter
- (void)requestAuthorizationWithOptions:(NSUInteger)options completionHandler:(void(^)(BOOL granted, NSError *__nullable error))completionHandler {
    // 正常执行通知权限，但如果涉及 Siri 则静默处理
    %orig;
}
%end

// 3. 构造函数注入：在 App 启动的最早期执行
%ctor {
    @autoreleasepool {
        NSLog(@"[SiriFix] Tweak Active. Shielding Swiftgram...");
        
        // 强制禁用 Intents 动态库的加载（如果尚未加载）
        void* handle = dlopen("/System/Library/Frameworks/Intents.framework/Intents", RTLD_NOW);
        if (handle) {
            %init;
        }
    }
}
