import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'amwal_api_platform_interface.dart';

/// An implementation of [AmwalApiPlatform] that uses method channels.
class MethodChannelAmwalApi extends AmwalApiPlatform {
  
  @visibleForTesting
  final methodChannel = const MethodChannel('amwal_api');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

   @override
  Future<String?> startPayment(String merchantId, String countryCode, String phoneNumber, double amount) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'merchantId': merchantId,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'amount': amount,
    };
    final String result = await methodChannel.invokeMethod('startPayment', args);
    return result;
  }

  //write method channel function for _adapter() method
    


  @override
  Future<String?> build(String merchantId, String countryCode, String phoneNumber) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'merchantId': merchantId,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
    };
    final String result = await methodChannel.invokeMethod('build', args);
    return result;
  }
  
}
