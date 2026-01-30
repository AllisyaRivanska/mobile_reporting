package com.example.mobile_reporting

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL_TEST = "notification_test"
    private val NOTIFICATION_CHANNEL_ID = "high_priority_channel"
    private val TAG = "MainActivity"
    private var pendingNotificationData: Map<String, String>? = null
    private var methodChannel: MethodChannel? = null

    companion object {
        const val EXTRA_DOCTYPE = "extra_doctype"
        const val EXTRA_NAME = "extra_name"
        const val EXTRA_STATE = "extra_state"
        const val EXTRA_FROM_NOTIFICATION = "extra_from_notification"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        
        checkAndHandleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
      
        checkAndHandleIntent(intent)
    }

    private fun checkAndHandleIntent(intent: Intent?) {
        
        if (intent == null) {
            return
        }
        
        intent.extras?.let { bundle ->
            for (key in bundle.keySet()) {
                Log.d(TAG, "   $key = ${bundle.get(key)}")
            }
        }
        
        val fromNotification = intent.getBooleanExtra(EXTRA_FROM_NOTIFICATION, false)
        
        if (fromNotification) {
            val doctype = intent.getStringExtra(EXTRA_DOCTYPE) ?: ""
            val name = intent.getStringExtra(EXTRA_NAME) ?: ""
            val state = intent.getStringExtra(EXTRA_STATE) ?: ""
            
            Log.d(TAG, "   Doctype: $doctype")
            Log.d(TAG, "   Name: $name")
            Log.d(TAG, "   State: $state")
            
            if (doctype.isNotEmpty()) {
                val data = mapOf(
                    "doctype" to doctype,
                    "name" to name,
                    "state" to state
                )
                
                sendToFlutter(data)
            } else {
                Log.w(TAG, "Doctype is empty")
            }
        } else {
            Log.d(TAG, "Normal app launch (not from notification)")
        }
    }

    private fun sendToFlutter(data: Map<String, String>) {
        if (methodChannel != null) {
            runOnUiThread {
                methodChannel?.invokeMethod("onNotificationTapped", data)
            }
        } else {
            pendingNotificationData = data
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        createNotificationChannel()

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_TEST)
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "showHeadsUpNotification" -> {
                    val title = call.argument<String>("title") ?: "Notifikasi"
                    val body = call.argument<String>("body") ?: ""
                    val doctype = call.argument<String>("doctype") ?: ""
                    val name = call.argument<String>("name") ?: ""
                    val state = call.argument<String>("state") ?: ""

                    showHeadsUpNotification(title, body, doctype, name, state)
                    result.success(true)
                }
                "getPendingNotification" -> {
                    result.success(pendingNotificationData)
                    pendingNotificationData = null
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        pendingNotificationData?.let { data ->
            runOnUiThread {
                methodChannel?.invokeMethod("onNotificationTapped", data)
                pendingNotificationData = null
            }
        }
        
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = NOTIFICATION_CHANNEL_ID
            val channelName = "Important Notifications"
            val importance = NotificationManager.IMPORTANCE_HIGH

            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = "Channel for important notifications"
                enableVibration(true)
                vibrationPattern = longArrayOf(0, 250, 250, 250)
                enableLights(true)
                lightColor = android.graphics.Color.BLUE
                setShowBadge(true)
                lockscreenVisibility = android.app.Notification.VISIBILITY_PUBLIC
            }

            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager?.createNotificationChannel(channel)

            Log.d(TAG, "Notification channel created")
        }
    }

    private fun showHeadsUpNotification(
        title: String,
        body: String,
        doctype: String,
        name: String,
        state: String
    ) {
      

        val notificationId = System.currentTimeMillis().toInt()
        
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or 
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP
            
            putExtra(EXTRA_FROM_NOTIFICATION, true)
            putExtra(EXTRA_DOCTYPE, doctype)
            putExtra(EXTRA_NAME, name)
            putExtra(EXTRA_STATE, state)
            
            action = "NOTIFICATION_ACTION_$notificationId"
        }
        

        val pendingIntent = PendingIntent.getActivity(
            this,
            notificationId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setCategory(NotificationCompat.CATEGORY_MESSAGE)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .setDefaults(NotificationCompat.DEFAULT_ALL)
            .setVibrate(longArrayOf(0, 250, 250, 250))
            .build()

        val notificationManager = getSystemService(NotificationManager::class.java)
        notificationManager?.notify(notificationId, notification)

        Log.d(TAG, "Notification posted with ID: $notificationId")
    }
}