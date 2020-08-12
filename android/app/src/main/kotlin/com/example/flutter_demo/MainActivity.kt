package com.example.flutter_demo

import com.example.flutter_demo.plugin.FlutterPluginCounter
import com.example.flutter_demo.plugin.FlutterPluginJumpToAct
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(FlutterPluginJumpToAct())
        flutterEngine.plugins.add(FlutterPluginCounter())
    }
}
