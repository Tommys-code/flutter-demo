package com.example.flutter_demo.plugin

import android.content.Context
import android.content.Intent
import android.util.Log
import com.example.flutter_demo.OneActivity
import com.example.flutter_demo.TwoActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry


class FlutterPluginJumpToAct : FlutterPlugin, MethodCallHandler {

    private var channel: MethodChannel? = null
    private lateinit var context: Context

    companion object {
        var CHANNEL_NAME = "com.tommy.jump/plugin"

        fun registerWith(registrar: PluginRegistry.Registrar) {
            val plugin = FlutterPluginJumpToAct()
            plugin.setupChannel(registrar.messenger(), registrar.activity())
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        teardownChannel()
    }

    private fun setupChannel(messenger: BinaryMessenger, context: Context) {
        this.context = context
        channel = MethodChannel(messenger, CHANNEL_NAME)
        channel?.setMethodCallHandler(this)
    }

    private fun teardownChannel() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "oneAct" -> {
                //跳转到指定Activity
                val intent = Intent(context, OneActivity::class.java)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(intent)
                //返回给flutter的参数
                result.success("success")
            }
            "twoAct" -> {
                //解析参数
                val text: String = call.argument("flutter") ?: ""
                //带参数跳转到指定Activity
                val intent = Intent(context, TwoActivity::class.java)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                intent.putExtra(TwoActivity.VALUE, text)
                context.startActivity(intent)
                //返回给flutter的参数
                result.success("success")
            }
            else -> result.notImplemented()
        }
    }

    fun getData(body: (data: String) -> Unit) {
        channel?.invokeMethod("getFlutterName", null, object : MethodChannel.Result {
            override fun success(o: Any?) {
                Log.i("qwe","success${o.toString()}")
                body.invoke(o?.toString() ?: "")
            }

            override fun error(s: String, s1: String?, o: Any?) {
                Log.i("qwe","error${s}")
            }
            override fun notImplemented() {
                Log.i("qwe","notImplemented}")
            }
        })
    }

}