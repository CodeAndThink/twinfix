package com.truongngo.twinfix

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.truongngo.twinfix.scanner.NativeScannerImpl
import com.truongngo.twinfix.scanner.ScannerHostApi

class MainActivity : FlutterActivity() {
    private var scannerImpl: NativeScannerImpl? = null
    private var scanServiceChannel: ScanServiceChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        // Register Native Scanner API
        scannerImpl = NativeScannerImpl(this, messenger)
        ScannerHostApi.setUp(messenger, scannerImpl!!)

        // Register Scan Foreground Service Channel
        scanServiceChannel = ScanServiceChannel(this)
        scanServiceChannel?.register(flutterEngine)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        scannerImpl?.dispose()
        scannerImpl = null
        scanServiceChannel?.dispose()
        scanServiceChannel = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
