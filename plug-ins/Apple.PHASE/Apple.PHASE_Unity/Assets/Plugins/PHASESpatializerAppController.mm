// ObjC project type counterpart of PHASESpatializerSwiftRegistration.mm.
//
// This file is masked to "XcodeProjectType: ObjectiveC" in its .meta, so exactly one of the two
// registration files is compiled into any given Xcode project.

#import "UnityAppController.h"

extern "C" {
struct UnityAudioEffectDefinition;
typedef int (*UnityPluginGetAudioEffectDefinitionsFunc)(
    struct UnityAudioEffectDefinition*** descptr);
extern void UnityRegisterAudioPlugin(
    UnityPluginGetAudioEffectDefinitionsFunc getAudioEffectDefinitions);
extern int UnityGetAudioEffectDefinitions(UnityAudioEffectDefinition*** definitionptr);
}  // extern "C"

@interface PHASESpatializerAppController : UnityAppController
- (void)shouldAttachRenderDelegate;
@end

@implementation PHASESpatializerAppController
- (void)shouldAttachRenderDelegate
{
    UnityRegisterAudioPlugin(UnityGetAudioEffectDefinitions);
}

@end
IMPL_APP_CONTROLLER_SUBCLASS(PHASESpatializerAppController);
