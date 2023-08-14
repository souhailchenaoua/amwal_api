#import "AmwalApiPlugin.h"

@implementation AmwalApiPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"amwal_api"
            binaryMessenger:[registrar messenger]];
  AmwalApiPlugin* instance = [[AmwalApiPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"startPayment" isEqualToString:call.method]) {
    NSDictionary *arguments = call.arguments;
    NSString *argumentsString = [NSString stringWithFormat:@"%@", arguments];
    NSString *resultString = [@"startPayment " stringByAppendingString:argumentsString];
    result(resultString);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end