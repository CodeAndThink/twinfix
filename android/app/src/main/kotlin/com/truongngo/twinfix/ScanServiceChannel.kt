package com.truongngo.twinfix

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * MethodChannel bridge between Dart and ScanForegroundService.
 * 
 * Dart calls:
 *   - startService({title, body})
 *   - updateProgress({title, body, current, total})
 *   - stopService({resultCount, completionTitle, completionBody, scanType})
 */
class ScanServiceChannel(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        private const val CHANNEL_NAME = "com.truongngo.twinfix/scan_service"
    }

    private var channel: MethodChannel? = null

    fun register(flutterEngine: FlutterEngine) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel?.setMethodCallHandler(this)
    }

    fun dispose() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startService" -> {
                val title = call.argument<String>("title") ?: "Scanning..."
                val body = call.argument<String>("body") ?: ""
                ScanForegroundService.start(context, title, body)
                result.success(null)
            }
            "updateProgress" -> {
                val title = call.argument<String>("title") ?: "Scanning..."
                val body = call.argument<String>("body") ?: ""
                val current = call.argument<Int>("current") ?: 0
                val total = call.argument<Int>("total") ?: 0
                ScanForegroundService.update(context, title, body, current, total)
                result.success(null)
            }
            "stopService" -> {
                val resultCount = call.argument<Int>("resultCount") ?: 0
                val completionTitle = call.argument<String>("completionTitle") ?: "Scan Complete"
                val completionBody = call.argument<String>("completionBody") ?: ""
                val scanType = call.argument<String>("scanType") ?: "duplicates"
                ScanForegroundService.stop(
                    context, resultCount, completionTitle, completionBody, scanType
                )
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}
