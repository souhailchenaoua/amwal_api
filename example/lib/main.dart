import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:amwal_api/amwal_api.dart' show AmwalApi, AmwalApiBuilder;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  

}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String merchantId = "your_merchant_id_here";
  String countryCode = "+213";
  String phoneNumber = "123456789";
  double amount = 100.0;
  AmwalApi amwal = AmwalApi(builder: AmwalApiBuilder().startPayment("yourMerchantId", "yourCountryCode", "yourPhoneNumber", 10.0),);
  @override
  void initState() {
    super.initState();
    initPlatformState();
    
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
      await amwal.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

Future<void> initiatePayment() async {
    String paymentResult = await amwal.startPayment(
      merchantId,
      countryCode,
      phoneNumber,
      amount,
    );
    // Handle the payment result here
    if (paymentResult == "success") {
      // Payment successful
    } else {
      // Payment failed
    }
    
    amwal.startPayment(merchantId, countryCode, phoneNumber, amount); 
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
