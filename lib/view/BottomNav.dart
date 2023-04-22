import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/view/DigitalTherapeutics.dart';
import 'package:flutter_alarm_app/view/SleepInfo.dart';
import 'package:flutter_alarm_app/view/SleepNoise.dart';
import 'package:flutter_alarm_app/view/Profile.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/DigitalTherapeutics.dart');
            break;
          case 1:
            Navigator.pushNamed(context, '/SleepInfo.dart');
            break;
          case 2:
            Navigator.pushNamed(context, '/home_screen.dart');
            break;
          case 3:
            Navigator.pushNamed(context, '/SleepNoise.dart');
            break;
          case 4:
            Navigator.pushNamed(context, '/Profile.dart');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline,),// 디지털 테라퓨틱스
          label: 'Digital\ntherapeutics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nightlight_outlined), // 수면정보
          label: 'Sleep\ninformation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm), // 알람
          label: 'Alarm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic_none), // 수면 소음
          label: 'Sleep Noise',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined), // 프로필
          label: 'Profile',
        ),
      ],
    );
  }
}
