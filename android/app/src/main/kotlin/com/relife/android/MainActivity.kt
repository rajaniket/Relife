package com.relife.android
import android.os.Bundle
import android.os.PersistableBundle
import web.o.alarm.Days
import web.o.alarm.MyAlarmListener
import web.o.alarm.MyAlarmManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.android.material.R
import android.app.Activity  
import android.content.Intent  
import android.net.Uri  
import io.flutter.plugin.common.MethodCall   
import io.flutter.plugin.common.MethodChannel.MethodCallHandler  
import io.flutter.plugin.common.MethodChannel.Result  
import io.flutter.plugins.GeneratedPluginRegistrant  




class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.relife/alarm"

   override 
    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
         
        
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
          call, result -> 
          if(call.method == "setAlarm")
          {
                val arguments = call.arguments()as Map<String,String>
                val hour = arguments["hour"]
                val min = arguments["min"]
                val alarmId = arguments["alarmId"]
                val authToken = arguments["authToken"]
                val habitId = arguments["habitId"]
                val notificationTitle = arguments["notificationTitle"]
                val notificationDescription = arguments["notificationDescription"]
                val fullPlanText = arguments["fullPlanText"]
                val habitPlanRemainderText = arguments["habitPlanRemainderText"]
                val startDays = arguments["startDays"]
                
                val mon = arguments["mon"]
                val tue = arguments["tue"]
                val wed = arguments["wed"]
                val thr = arguments["thr"]
                val fri = arguments["fri"]
                val sat = arguments["sat"]
                val sun = arguments["sun"]
                
                
               // print(
               //     "Alarm Succeed_______________ mon: $mon, tue: $tue, wed: $wed, thr: $thr, fri: $fri, sat: $sat, sun: $sun, startDate:$startDays \n");

                setAlarm(hour!!.toInt(),min!!.toInt(),alarmId!!.toInt(),authToken!!,habitId!!,notificationTitle!!,notificationDescription!!,fullPlanText!!,habitPlanRemainderText!!,startDays,mon!!.toInt(),tue!!.toInt(),wed!!.toInt(),thr!!.toInt(),fri!!.toInt(),sat!!.toInt(),sun!!.toInt());
              
              
          }
          if(call.method=="cancelAlarm"){
            val arguments = call.arguments()as Map<String,String>
            val alarmId = arguments["alarmId"]
            cancelAlarm(alarmId!!.toInt());
          }
          if(call.method=="test"){
              test();
          }
        }
    }



    private fun cancelAlarm(id:Int){
        MyAlarmManager.cancelAlarm(context, id)
    }

    private fun test(){
        print("inside test1");
        MyAlarmManager.printMyAlarmsTimeStamp(context)
        print("inside test2");
    }



    private fun setAlarm(hour:Int , min:Int, alarmId:Int, authToken:String, habitId:String, notificationTitle:String, notificationDescription:String, fullPlanText:String, habitPlanRemainderText:String,startDays:String?, mon:Int, tue : Int, wed : Int,thr : Int,fri : Int,sat : Int,sun : Int )  {
        print("Alarm Data Native Side___________________________\n hour: $hour\nmin: $min\nstart date: $startDays \n");
        print(
            "mon: $mon\ntue: $tue\nwed: $wed\nthr: $thr\nfri: $fri\nsat: $sat\nsun: $sun \n");
        print("alarm Id: $alarmId \nhabitId:$habitId \nauthToken: $authToken\nnotification title: $notificationTitle\nnotification description: $notificationDescription\nfullPlanText: $fullPlanText\nhabit plan remainder text: $habitPlanRemainderText\n");
        
   //   val days : List<String> = Listof(Days.MONDAY,Days.TUESDAY,Days.WEDNESDAY,Days.THURSDAY,Days.FRIDAY,Days.SATURDAY,Days.SUNDAY);
        var days: ArrayList<Int> = ArrayList()
       
        if(mon==1)
        days.add(Days.MONDAY)
        if(tue==1)
        days.add(Days.TUESDAY)
        if(wed==1)
        days.add(Days.WEDNESDAY)
        if(thr==1)
        days.add(Days.THURSDAY)
        if(fri==1)
        days.add(Days.FRIDAY)
        if(sat==1)
        days.add(Days.SATURDAY)
        if(sun==1)
        days.add(Days.SUNDAY)

        

        MyAlarmManager.createAlarm(this,object: MyAlarmListener{
            override fun getAuthToken(): String = authToken//"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MWNhZDliZDQ5MDlmOTAwMTE4YjQyODMiLCJpYXQiOjE2NDE1NjgwNTUsImV4cCI6MTY0MTY1NDQ1NX0.dbxul59YYwlC16ZRtupNwueV1SSEY_R8gq1_C_kRaVg"
            override fun getHabitId(): String = habitId//"61c9ad33e5d53c0011dab03e"
            
            override fun getPlan(): String = fullPlanText//"after i have dinner ⏳\ni’ll read for 15 mins 😇\nso that i can watch netflix 🙈"   // 

            override fun getHabitPlan(): String = habitPlanRemainderText//"it’s time to read!"   //

            override fun getDescription(): String {  // notification (fixed)
                return notificationDescription; //"don't break your streak 🔥";
            }

            override fun getId(): Int {
                return alarmId;
            }

            override fun getTitle(): String {  // notification
               return notificationTitle;//"it's time to read";
            }

            override fun listOfDays(): ArrayList<Int> { 
                return days;
            }

            override fun listOfTimesInSec(): ArrayList<Long> {
                return arrayListOf((((hour * 60) + min) * 60).toLong());  
            }

            override fun startDate(): String? {  // formate of startDate to be ask ?
                return startDays;
            }

        })

            
        // test();
     
    }
}