package com.example.amwal_api

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.os.Build
import android.os.Build.VERSION_CODES
import android.os.Build.VERSION

class AmwalApiPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "amwal_api")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }

    if (call.method == "startPayment")
      startPayment((String) call.argument("merchantId"), (String) call.argument("countryCode"), (String) call.argument("phoneNumber"), (String) call.argument("amount"))
    else{
      result.notImplemented()
    }
  }

  private fun startPayment(merchantId: String, countryCode: String, phoneNumber: String, amount: String) {
        // Implement the payment logic here
  }  

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
