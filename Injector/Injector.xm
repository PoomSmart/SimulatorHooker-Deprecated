#import "../Common.h"

@interface FBApplicationInfo : NSObject
@end

@interface SBApplicationInfo : FBApplicationInfo
- (NSString *)bundleIdentifier;
@end

NSString *dylibPaths(NSString *names){
    NSMutableString *dylibs = [NSMutableString string];
    if (names && names.length > 0) {
        NSArray *paths = [names componentsSeparatedByString:@","];
        for (NSString *name in paths) {
            if ([name hasSuffix:@"-MAIN"]) {
                name = [name stringByReplacingOccurrencesOfString:@"-MAIN" withString:@""];
                [dylibs appendString:SH_PATH_2(name)];
                [dylibs appendString:@":"];
            } else
                [dylibs appendString:[NSString stringWithFormat:@"%@:", SH_PATH(name)]];
        }
    }
    [dylibs appendString:SH_PATH_2(@"FLEXDylib")];
    return dylibs;
}

NSDictionary *overridedEnv(NSDictionary *orig, SBApplicationInfo *self){
    NSString *bundleIdentifier = self.bundleIdentifier;
    NSMutableDictionary *env = orig ? orig.mutableCopy : [NSMutableDictionary dictionary];
    if ([bundleIdentifier isEqualToString:@"com.apple.camera"])
        env[@"DYLD_INSERT_LIBRARIES"] = dylibPaths(@"CameraEnabler");
    else
        env[@"DYLD_INSERT_LIBRARIES"] = dylibPaths(@"");
    NSLog(@"%@ for bundleIdentifier: %@", env, bundleIdentifier);
    return env;
}

%hook SBApplicationInfo

- (NSDictionary *)environmentVariables
{
    return overridedEnv(%orig, self);
}

%end

__attribute__((constructor)) static void init(){
    runIn(@"SpringBoard");
}
