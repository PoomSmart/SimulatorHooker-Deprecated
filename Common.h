#import <Foundation/Foundation.h>

#define SH_ROOT @"/Users/PoomSmart/Desktop/CydiaTweaks/SimulatorHooker"
#define SH_PATH_2(name) [NSString stringWithFormat:@"%@/%@/%@.dylib", SH_ROOT, name, name]
#define SH_PATH(name) [NSString stringWithFormat:@"%@/.theos/obj/iphone_simulator/%@.dylib", SH_ROOT, name]

#define runIn(process) NSLog(@"%@", [NSString stringWithFormat:@"========== init for %@ ==========", process])
