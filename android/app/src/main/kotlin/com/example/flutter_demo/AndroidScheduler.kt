package com.example.flutter_demo

import android.os.Handler
import android.os.Looper
import io.reactivex.Scheduler
import io.reactivex.schedulers.Schedulers
import java.util.concurrent.Executor


class AndroidScheduler private constructor(): Executor {

    companion object{
        private var instance: AndroidScheduler? = null

        @Synchronized
        fun mainThread(): Scheduler? {
            if (instance == null) {
                instance = AndroidScheduler()
            }
            return instance!!.mMainScheduler
        }
    }

    private val mMainScheduler: Scheduler = Schedulers.from(this)
    private val mHandler: Handler = Handler(Looper.myLooper())

    override fun execute(command: Runnable?) {
        mHandler.post(command)
    }


}