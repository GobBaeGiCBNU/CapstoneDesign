import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_alarm_app/service/alarm_scheduler.dart';
import 'package:flutter_alarm_app/view/DigitalTherapeutics.dart';
import 'package:flutter_alarm_app/view/Main_screen.dart';
import 'package:flutter_alarm_app/view/Profile.dart';
import 'package:flutter_alarm_app/view/SleepInfo.dart';
import 'package:flutter_alarm_app/view/SleepNoise.dart';
import 'package:provider/provider.dart';


class HomeState extends State<HomeScreen> {

  int _selectedIndex = 2;

  static List<Widget> pages = <Widget>[
    DigitalTherapeutics(),
    SleepInfo(),
    Main_screen(),
    SleepNoise(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          children: [
            Flexible(child: Image.asset('./assets/logo.png', width: 180,)),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 10, 0),
              child: Text('Alarm For Sleep',
                style: TextStyle(fontSize: 15, color: Colors.black45),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(1, 1, 1, 0),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline,),// 디지털 테라퓨틱스
            label: 'Tip',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_outlined), // 수면정보
            label: 'Sleep',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.alarm), // 알람
            label: 'Alarm',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.mic_none), // 수면 소음
            label: 'Noise',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), // 프로필
            label: 'Profile',
            ),
          ],
        ),
      )
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({
    Key? key,
    required this.alarm,
    required this.onTapSwitch,
    required this.onTapCard,
  }) : super(key: key);

  final Alarm alarm;
  final void Function(bool enabled) onTapSwitch;
  final VoidCallback onTapCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTapCard,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  alarm.timeOfDay.format(context),
                  style: theme.textTheme.headline6!.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(
                      alarm.enabled ? 1.0 : 0.4,
                    ),
                  ),
                ),
              ),
              Switch(
                value: alarm.enabled,
                onChanged: onTapSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
