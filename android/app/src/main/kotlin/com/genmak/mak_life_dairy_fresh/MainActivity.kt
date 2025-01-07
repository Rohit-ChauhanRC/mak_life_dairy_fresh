package com.genmak.mak_life_dairy_fresh

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.genmak.mak_life_dairy_fresh/upi"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "handleUPIUrl") {
                val url = call.argument<String>("url")
                if (url != null && url.startsWith("upi://pay")) {
                    handleUPIUrl(url)
                    result.success(true)
                } else {
                    result.error("INVALID_URL", "The URL is not valid", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun handleUPIUrl(url: String) {
        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(url)
        startActivity(intent)
    }
}
