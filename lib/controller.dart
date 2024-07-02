import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:timer_sample/timer_status.dart';

class MyController {

  Rx<TimerStatus> timeElapsed = TimerStatus().obs;

  void startTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int startTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('startTime', startTime);
    timeElapsed.value = Counting(0);
  }

  void stopTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('startTime');
    timeElapsed.value = Idle();
  }

  void checkTimerStatus() async {
    timeElapsed.value = Checking();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final startTime = prefs.getInt('startTime');
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    if(startTime == null || (currentTime - startTime)/1000 > 60)
      timeElapsed.value = Idle();
    else
      timeElapsed.value = Counting(((currentTime - startTime)/1000).round());
  }
}