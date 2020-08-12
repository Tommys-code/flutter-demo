package com.example.flutter_demo

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.Button

class OneActivity : Activity(), View.OnClickListener {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.act_one)

        findViewById<Button>(R.id.go_flutter).setOnClickListener(this)
    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.go_flutter -> {

            }
        }
    }
}