#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  [GSMServices provideAPIKey: @AIzaSyDRRefOZRvjQhOBg6NsShggOIix9hrvtFM]
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
