package com.example.flutter_demo

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class TwoActivity :Activity(){

    companion object{
        const val VALUE = "value"
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.act_two)

        val value = intent.getStringExtra(VALUE)
        findViewById<TextView>(R.id.text).text = value
    }

}