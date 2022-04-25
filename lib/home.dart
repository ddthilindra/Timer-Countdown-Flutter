import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const countdownDuration = Duration(minutes: 1);
  Duration duration = Duration();
  Timer? timer;

  bool isCountDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
    reset();
  }

  reset() {
    if (isCountDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds - addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    //9-->09
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Scaffold(
      body: Center(
        child: Text(
          '$minutes:$seconds',
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}
