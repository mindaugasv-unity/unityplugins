// Swift project type counterpart of PHASESpatializerAppController.mm.
//
// This file is masked to "XcodeProjectType: Swift" in its .meta, so exactly one of the two
// registration files is compiled into any given Xcode project.

#import <Foundation/Foundation.h>
#import <UnityAPI/UnityAPI-Swift.h>

extern "C" {
struct UnityAudioEffectDefinition;
typedef int (*UnityPluginGetAudioEffectDefinitionsFunc)(
    struct UnityAudioEffectDefinition*** descptr);
extern void UnityRegisterAudioPlugin(
    UnityPluginGetAudioEffectDefinitionsFunc getAudioEffectDefinitions);
extern int UnityGetAudioEffectDefinitions(UnityAudioEffectDefinition*** definitionptr);
}  // extern "C"


@interface PHASESpatializerRegistration : NSObject
@end

@implementation PHASESpatializerRegistration

static id sPHASERuntimeInitObserver = nil;

+ (void)load
{
    sPHASERuntimeInitObserver =
        [[NSNotificationCenter defaultCenter] addObserverForName:UnityNotifications.unityDidInitializeRuntime
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification* note) {
            UnityRegisterAudioPlugin(UnityGetAudioEffectDefinitions);

            if (sPHASERuntimeInitObserver != nil)
            {
                [[NSNotificationCenter defaultCenter] removeObserver:sPHASERuntimeInitObserver];
                sPHASERuntimeInitObserver = nil;
            }
        }];
}

@end
