import 'dart:ffi';

import 'amwal_api_platform_interface.dart';
import 'package:flutter/services.dart';

class AmwalApi {
  final String merchantId;
  final String countryCode;
  final String phoneNumber;
  final double amount;
  final MethodChannel _channel;

  AmwalApi._({
    required this.merchantId,
    required this.countryCode,
    required this.phoneNumber,
    required this.amount,
    required MethodChannel channel,
  }) : _channel = channel;

  factory AmwalApi({required AmwalApiBuilder builder}) {
    final channel = MethodChannel('amwal_api');
    return builder
        .startPayment(builder._merchantId, builder._countryCode,
            builder._phoneNumber, builder._amount)
        .build(channel: channel);
  }

  Future<String> startPayment(String merchantId, String countryCode,
      String phoneNumber, double amount) async {
    final Map<String, dynamic> args = <String, dynamic>{
      'merchantId': merchantId,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'amount': amount,
    };
    final dynamic result = await _channel.invokeMethod('startPayment', args);
    return result as String;
  }

  Future<String?> getPlatformVersion() {
    return AmwalApiPlatform.instance.getPlatformVersion();
  }

  Map<String, String> _adapter() {
    return {
      'merchantId': merchantId,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'amount': amount.toString(),
    };
  }
}

class AmwalApiBuilder {
  String _merchantId = "";
  String _countryCode = "";
  String _phoneNumber = "";
  double _amount = 0.0 ;

  AmwalApiBuilder startPayment(
      String merchantId, String countryCode, String phoneNumber, double amount) {
    _merchantId = merchantId;
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    _amount = amount;
    return this;
  }

  AmwalApi build({required MethodChannel channel}) {
    if (_merchantId.isEmpty) {
     throw Exception("Merchant Id has to be provided");
    }

    return AmwalApi._(
      merchantId: _merchantId,
      countryCode: _countryCode,
      phoneNumber: _phoneNumber,
      amount: _amount,
      channel: channel,
    );
  }
}

abstract class AmwalMethodCallHandler {
  Future<dynamic> handleMethodCall(MethodCall call);
}

abstract class AmwalPlatformInterface {
  AmwalMethodCallHandler get methodCallHandler;
}
