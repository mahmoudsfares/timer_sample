import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:timer_sample/controller.dart';
import 'package:get/get.dart';
import 'package:timer_sample/timer_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  MyController myController = MyController();
  CountDownController countdownController = CountDownController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myController.checkTimerStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (myController.timeElapsed.value is Checking)
                  return SizedBox();
                else if ((myController.timeElapsed.value is Counting)) {
                  int elapsed =
                      (myController.timeElapsed.value as Counting).elapsedTime;
                  return CircularCountDownTimer(
                    duration: 60,
                    initialDuration: elapsed,
                    controller: countdownController,
                    onComplete: () {
                      myController.stopTimer();
                    },
                    isReverse: true,
                    isReverseAnimation: true,
                    width: 50,
                    height: 50,
                    fillColor: Colors.blue,
                    ringColor: Colors.black,
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        myController.startTimer();
                        // when a timer still has elapsed time when the application starts,
                        // it won't start automatically. start() must be called to allow
                        // the timer to start using the initialDuration
                        countdownController.start();
                      },
                      child: Text('start'));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
