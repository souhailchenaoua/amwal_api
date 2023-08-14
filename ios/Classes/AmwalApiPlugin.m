#import "AmwalApiPlugin.h"
#import <AmwalPayment/AmwalPayment.h>

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
    NSString *currency = arguments[@"currency"];
    NSNumber *amount = arguments[@"amount"];
    NSNumber *vat = arguments[@"vat"];
    NSString *merchantId = arguments[@"merchantId"];

    AmwalPaymentView *paymentView = [[AmwalPaymentView alloc] initWithCurrency:currency
                                                                        amount:amount
                                                                           vat:vat
                                                                    merchantId:merchantId
                                                                    completion:^{
                                                                        // Payment completion block
                                                                        result(@"Payment completed successfully.");
                                                                    }];

    // Present the payment view
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:paymentView animated:YES completion:nil];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end