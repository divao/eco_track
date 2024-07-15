package com.example.cachoeira_ferreira

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity : FlutterActivity() {
    private val CHANNEL = "ecoTrack/systemOSVersion"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getSystemOSVersion") {
                val systemOS = getSystemOSVersion()

                result.success(systemOS)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getSystemOSVersion(): String {
        val systemOS: String
        val releaseNumber = android.os.Build.VERSION.RELEASE
        systemOS = "Android $releaseNumber"

        return systemOS
    }
}
