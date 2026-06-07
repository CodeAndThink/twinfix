package com.truongngo.twinfix

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.truongngo.twinfix.scanner.NativeScannerImpl
import com.truongngo.twinfix.scanner.ScannerHostApi

class MainActivity : FlutterActivity() {
    private var scannerImpl: NativeScannerImpl? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        // Register Native Scanner API
        scannerImpl = NativeScannerImpl(this, messenger)
        ScannerHostApi.setUp(messenger, scannerImpl!!)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        scannerImpl?.dispose()
        scannerImpl = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
