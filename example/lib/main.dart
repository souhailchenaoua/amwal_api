import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:amwal_api/amwal_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String merchantId = "your_merchant_id_here";
  String countryCode = "+213";
  String phoneNumber = "123456789";
  double amount = 100.0;
  AmwalApi amwal = AmwalApi(
      builder: AmwalApiBuilder()
          .startPayment('merchantId', 'countryCode', 'phoneNumber', 0.0));
  String paymentResult = 'Null';
  int count = 0;

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
    try {
      paymentResult = await amwal.startPayment(
          merchantId, countryCode, phoneNumber, amount);
      // Handle the result
      print(paymentResult);
    } catch (error) {
      // Handle any errors that occurred during the payment process
    }

    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: initiatePayment,
                child: const Text('Start Payment'),
              ),
              Text(' $paymentResult + $count'),
              Text(
                'Running on: $_platformVersion\n',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
