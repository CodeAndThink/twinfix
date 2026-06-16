package com.truongngo.twinfix

import android.app.*
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat

class ScanForegroundService : Service() {

    companion object {
        const val CHANNEL_ID = "scan_channel"
        const val NOTIFICATION_ID = 9001
        const val COMPLETION_NOTIFICATION_ID = 9002

        const val ACTION_START = "ACTION_START"
        const val ACTION_UPDATE = "ACTION_UPDATE"
        const val ACTION_STOP = "ACTION_STOP"

        const val EXTRA_TITLE = "extra_title"
        const val EXTRA_BODY = "extra_body"
        const val EXTRA_CURRENT = "extra_current"
        const val EXTRA_TOTAL = "extra_total"
        const val EXTRA_RESULT_COUNT = "extra_result_count"
        const val EXTRA_COMPLETION_TITLE = "extra_completion_title"
        const val EXTRA_COMPLETION_BODY = "extra_completion_body"
        const val EXTRA_SCAN_TYPE = "extra_scan_type"

        fun start(context: Context, title: String, body: String) {
            val intent = Intent(context, ScanForegroundService::class.java).apply {
                action = ACTION_START
                putExtra(EXTRA_TITLE, title)
                putExtra(EXTRA_BODY, body)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun update(context: Context, title: String, body: String, current: Int, total: Int) {
            val intent = Intent(context, ScanForegroundService::class.java).apply {
                action = ACTION_UPDATE
                putExtra(EXTRA_TITLE, title)
                putExtra(EXTRA_BODY, body)
                putExtra(EXTRA_CURRENT, current)
                putExtra(EXTRA_TOTAL, total)
            }
            context.startService(intent)
        }

        fun stop(
            context: Context,
            resultCount: Int,
            completionTitle: String,
            completionBody: String,
            scanType: String
        ) {
            val intent = Intent(context, ScanForegroundService::class.java).apply {
                action = ACTION_STOP
                putExtra(EXTRA_RESULT_COUNT, resultCount)
                putExtra(EXTRA_COMPLETION_TITLE, completionTitle)
                putExtra(EXTRA_COMPLETION_BODY, completionBody)
                putExtra(EXTRA_SCAN_TYPE, scanType)
            }
            context.startService(intent)
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> {
                val title = intent.getStringExtra(EXTRA_TITLE) ?: "Scanning..."
                val body = intent.getStringExtra(EXTRA_BODY) ?: ""
                startForegroundWithNotification(title, body)
            }
            ACTION_UPDATE -> {
                val title = intent.getStringExtra(EXTRA_TITLE) ?: "Scanning..."
                val body = intent.getStringExtra(EXTRA_BODY) ?: ""
                val current = intent.getIntExtra(EXTRA_CURRENT, 0)
                val total = intent.getIntExtra(EXTRA_TOTAL, 0)
                updateNotification(title, body, current, total)
            }
            ACTION_STOP -> {
                val resultCount = intent.getIntExtra(EXTRA_RESULT_COUNT, 0)
                val completionTitle = intent.getStringExtra(EXTRA_COMPLETION_TITLE) ?: "Scan Complete"
                val completionBody = intent.getStringExtra(EXTRA_COMPLETION_BODY) ?: ""
                val scanType = intent.getStringExtra(EXTRA_SCAN_TYPE) ?: "duplicates"
                showCompletionNotification(resultCount, completionTitle, completionBody, scanType)
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
            }
        }
        return START_NOT_STICKY
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Photo Scan",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Notification for background photo scanning"
                setShowBadge(false)
            }
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    private fun startForegroundWithNotification(title: String, body: String) {
        val notification = buildProgressNotification(title, body, 0, 0)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    private fun updateNotification(title: String, body: String, current: Int, total: Int) {
        val notification = buildProgressNotification(title, body, current, total)
        val manager = getSystemService(NotificationManager::class.java)
        manager.notify(NOTIFICATION_ID, notification)
    }

    private fun buildProgressNotification(
        title: String,
        body: String,
        current: Int,
        total: Int
    ): Notification {
        // Tap notification → open app at current screen
        val openIntent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        val pendingIntent = PendingIntent.getActivity(
            this, 0, openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title)
            .setContentText(body)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setSilent(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)

        if (total > 0) {
            builder.setProgress(total, current, false)
        } else {
            builder.setProgress(0, 0, true) // indeterminate
        }

        return builder.build()
    }

    private fun showCompletionNotification(
        resultCount: Int,
        title: String,
        body: String,
        scanType: String
    ) {
        // Tap → open app with scan type info so Flutter can navigate
        val openIntent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
            putExtra("scan_complete", true)
            putExtra("scan_type", scanType)
            putExtra("result_count", resultCount)
        }
        val pendingIntent = PendingIntent.getActivity(
            this, 1, openIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title)
            .setContentText(body)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .build()

        val manager = getSystemService(NotificationManager::class.java)
        manager.notify(COMPLETION_NOTIFICATION_ID, notification)
    }
}
