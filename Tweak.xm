#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface FakeINPreferences : NSObject
@end

@implementation FakeINPreferences

+ (void)requestSiriAuthorization:(void (^)(NSInteger status))completion {

    NSLog(@"[SideloadFix] Fake Siri authorization");

    if (completion) {
        completion(1);
    }
}

+ (NSInteger)siriAuthorizationStatus {
    return 1;
}

@end


static void installFakeSiri() {

    Class cls = objc_getClass("INPreferences");

    if (!cls) {

        NSLog(@"[SideloadFix] Creating fake INPreferences");

        cls = objc_allocateClassPair([NSObject class], "INPreferences", 0);

        class_addMethod(cls,
                        @selector(requestSiriAuthorization:),
                        (IMP)[FakeINPreferences methodForSelector:@selector(requestSiriAuthorization:)],
                        "v@:@");

        class_addMethod(cls,
                        @selector(siriAuthorizationStatus),
                        (IMP)[FakeINPreferences methodForSelector:@selector(siriAuthorizationStatus)],
                        "q@:");

        objc_registerClassPair(cls);

    } else {

        NSLog(@"[SideloadFix] Replacing INPreferences");

        object_setClass((id)cls, [FakeINPreferences class]);
    }
}


%hook NSBundle

- (id)objectForInfoDictionaryKey:(NSString *)key {

    if ([key isEqualToString:@"aps-environment"]) {
        return nil;
    }

    if ([key containsString:@"app-group"]) {
        return nil;
    }

    return %orig;
}

%end


%ctor {

    NSLog(@"[SideloadFix] Loaded");

    installFakeSiri();
}
