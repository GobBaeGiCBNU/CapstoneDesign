import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_alarm_app/service/alarm_scheduler.dart';
import 'package:flutter_alarm_app/view/DigitalTherapeutics.dart';
import 'package:flutter_alarm_app/view/Profile.dart';
import 'package:flutter_alarm_app/view/SleepInfo.dart';
import 'package:flutter_alarm_app/view/SleepNoise.dart';
import 'package:provider/provider.dart';
import 'package:flutter_alarm_app/view/BottomNav.dart';

class Main_screen extends StatelessWidget {
  const Main_screen({Key? key}) : super(key: key);

  void _createAlarm(
      BuildContext context,
      AlarmListProvider alarmListProvider,
      ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 30),
    );
    if (time == null) return;

    final alarm = Alarm(
      id: alarmListProvider.getAvailableAlarmId(),
      hour: time.hour,
      minute: time.minute,
      enabled: true,
    );

    alarmListProvider.add(alarm);
    await AlarmScheduler.scheduleRepeatable(alarm);
  }

  void _switchAlarm(
      AlarmListProvider alarmListProvider,
      Alarm alarm,
      bool enabled,
      ) async {
    final newAlarm = alarm.copyWith(enabled: enabled);
    alarmListProvider.replace(
      alarm,
      newAlarm,
    );
    if (enabled) {
      await AlarmScheduler.scheduleRepeatable(newAlarm);
    } else {
      await AlarmScheduler.cancelRepeatable(newAlarm);
    }
  }

  void _handleCardTap(
      AlarmListProvider alarmList,
      Alarm alarm,
      BuildContext context,
      ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: alarm.timeOfDay,
    );
    if (time == null) return;

    final newAlarm = alarm.copyWith(hour: time.hour, minute: time.minute);

    alarmList.replace(alarm, newAlarm);
    if (alarm.enabled) await AlarmScheduler.cancelRepeatable(alarm);
    if (newAlarm.enabled) await AlarmScheduler.scheduleRepeatable(newAlarm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            _createAlarm(context, context.read<AlarmListProvider>());
          },
          child: const Icon(Icons.add, color: Colors.white,),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Consumer<AlarmListProvider>(
                  builder: (context, alarmList, child) => ListView.builder(
                    itemCount: alarmList.length,
                    itemBuilder: (context, index) {
                      final alarm = alarmList[index];
                      return _AlarmCard(
                        alarm: alarm,
                        onTapSwitch: (enabled) {
                          _switchAlarm(alarmList, alarm, enabled);
                        },
                        onTapCard: () {
                          _handleCardTap(alarmList, alarm, context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
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
