package com.example.amwal_api
import tech.amwal.payment.*
import tech.amwal.payment.PaymentSheet
import tech.amwal.payment.PaymentSheetResult 
import tech.amwal.payment.dsl.paymentSheet
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
        val amount = call.argument<Float>("amount")

        if (merchantId != null && countryCode != null && phoneNumber != null && amount != null) {
            // call the Android Amwal SDK
            
            //Creating a payment sheet with configurations
            
          val paymentSheet = PaymentSheet.paymentSheet(merchantId) {
 
          }

        paymentSheet.show(
            PaymentSheet.Amount(
                total = 220F, tax = 0.0f, shipping = 0.0f, discount = 0.0f
            )
        ) { result: PaymentSheetResult ->
            when (result) {
                PaymentSheetResult.Canceled -> {

                }

                PaymentSheetResult.Completed -> {

                }

                is PaymentSheetResult.Failed -> {}
            }
        }
            
            result.success("p Info:" + merchantId + ", "+ countryCode + ", "+ phoneNumber + ", "+ amount)
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
