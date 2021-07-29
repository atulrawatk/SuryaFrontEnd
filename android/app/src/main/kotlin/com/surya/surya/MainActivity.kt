package com.surya.surya

import android.app.AlertDialog
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioManager
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.os.Build
import android.os.Bundle
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity: FlutterActivity() {
    var permission = arrayOf<String>("android.permission.WRITE_EXTERNAL_STORAGE",
            "android.permission.CAMERA","android.permission.RECORD_AUDIO",
            "android.permission.READ_CONTACTS","android.permission.WRITE_CONTACTS")
    @RequiresApi(Build.VERSION_CODES.N)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestPermission()
        MethodChannel(flutterEngine?.dartExecutor, "com.surya.surya")
                .setMethodCallHandler { methodCall, result ->
                    if (methodCall.method == "firebaseToken") {
                        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
                            if (!task.isSuccessful) {
                                return@OnCompleteListener
                            }
                            val token = task.result
                            Log.d("FirebaseToken", token.toString())
                            result.success("$token")
                        })
                    }

                }
    }
    private fun requestPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Log.d("permission",""+permission[0])
            ActivityCompat.requestPermissions(this,permission,200)
        }
    }
}
