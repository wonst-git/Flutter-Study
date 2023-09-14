import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  static const settingSeconds = 120;

  bool isRunning = false;
  int totalPomodoros = 0;
  int totalSeconds = settingSeconds;
  Timer? timer;

  void onTick(Timer timer) {
    setState(() {
      if (totalSeconds == 1) {
        onReset();

        totalPomodoros++;
      } else {
        totalSeconds--;
      }
    });
  }

  void onStartPressed() {
    isRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onStopPressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onReset() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = settingSeconds;
    });
  }

  String dateFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    const regex = r'.*:([0-9]{2}:[0-9]{2}).[0-9]*';

    return RegExp(regex).matchAsPrefix(duration.toString())?.group(1) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).cardColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                dateFormat(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onStopPressed : onStartPressed,
                  icon: Icon(
                    isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline,
                  ),
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
                IconButton(
                  onPressed: onReset,
                  icon: const Icon(
                    Icons.settings_backup_restore_outlined,
                  ),
                  iconSize: 40,
                  color: Theme.of(context).cardColor,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
