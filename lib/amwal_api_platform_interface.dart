import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'amwal_api_method_channel.dart';

abstract class AmwalApiPlatform extends PlatformInterface {
  AmwalApiPlatform() : super(token: _token);

  static final Object _token = Object();

  static AmwalApiPlatform _instance = MethodChannelAmwalApi();


  static AmwalApiPlatform get instance => _instance;


  static set instance(AmwalApiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }


  Future<String?> startPayment(String merchantId, String countryCode, String phoneNumber, double amount) {
    throw UnimplementedError('startPayment() has not been implemented.');
  }

  Future<String?> _adapter() {
    throw UnimplementedError('_toMap() has not been implemented.');
  }
  
  Future<String?> build(String merchantId, String countryCode, String phoneNumber) {
    throw UnimplementedError('build() has not been implemented.');
  }

  

}
