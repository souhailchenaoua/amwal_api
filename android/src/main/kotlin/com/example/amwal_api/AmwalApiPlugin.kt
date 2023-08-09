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
    } 
    if (call.method == "startPayment") {
        val merchantId = call.argument<String>("merchantId")
        val countryCode = call.argument<String>("countryCode")
        val phoneNumber = call.argument<String>("phoneNumber")
        val amount = call.argument<Double>("amount")

        if (merchantId != null && countryCode != null && phoneNumber != null && amount != null) {
            // Implement the payment logic here
            result.success("Payment started successfully")
        } else {
            result.error("INVALID_ARGUMENTS", "One or more arguments are missing or invalid", null)
        }
    } else {
        result.notImplemented()
    }
}
  
 

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
