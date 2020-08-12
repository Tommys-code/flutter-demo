package com.example.flutter_demo.plugin

import android.content.Context
import com.example.flutter_demo.AndroidScheduler
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.reactivex.Observable
import io.reactivex.Observer
import io.reactivex.disposables.Disposable
import java.util.concurrent.TimeUnit

class FlutterPluginCounter : FlutterPlugin, EventChannel.StreamHandler {

    private var channel: EventChannel? = null

    companion object {
        private const val CHANNEL_NAME = "com.tommy.counter/plugin"
    }

    private fun setupChannel(messenger: BinaryMessenger, context: Context) {
        channel = EventChannel(messenger, CHANNEL_NAME)
        channel?.setStreamHandler(this)
    }

    private fun teardownChannel() {
        channel?.setStreamHandler(null)
        channel = null
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        teardownChannel()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Observable.interval(1, TimeUnit.SECONDS)
                .take(60)
                .observeOn(AndroidScheduler.mainThread())
                .subscribe(object : Observer<Long> {
                    override fun onComplete() {
                        events?.success("倒计时结束")
                    }

                    override fun onSubscribe(d: Disposable) {

                    }

                    override fun onNext(t: Long) {
                        events?.success(t.toInt())
                    }

                    override fun onError(e: Throwable) {
                        events?.error("计时器异常", "异常", e.message)
                    }

                }
                )
    }

    override fun onCancel(arguments: Any?) {

    }

}