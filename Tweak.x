#import <Foundation/Foundation.h>
#import <Intents/Intents.h>
#import <CallKit/CallKit.h>

%hook INPreferences

+ (void)requestSiriAuthorization:(void (^)(INSiriAuthorizationStatus status))completion {

    NSLog(@"[SideloadFix] Block Siri request");

    if (completion) {
        completion(INSiriAuthorizationStatusDenied);
    }
}

+ (INSiriAuthorizationStatus)siriAuthorizationStatus {
    return INSiriAuthorizationStatusDenied;
}

%end


%hook NSBundle

- (id)objectForInfoDictionaryKey:(NSString *)key {

    if ([key isEqualToString:@"com.apple.developer.siri"]) {
        return nil;
    }

    if ([key isEqualToString:@"aps-environment"]) {
        return nil;
    }

    return %orig;
}

%end


%hook CXCallObserver

- (instancetype)init {

    NSLog(@"[SideloadFix] Disable CallKit");

    return nil;
}

%end


%hook NSUserDefaults

- (id)objectForKey:(NSString *)defaultName {

    if ([defaultName containsString:@"group."]) {

        NSLog(@"[SideloadFix] Block AppGroup access");

        return nil;
    }

    return %orig;
}

%end


%ctor {

    NSLog(@"[SideloadFix] Telegram sideload patch loaded");

}
