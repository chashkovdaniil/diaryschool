import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../../utilities/notifications.dart';

import 'widgets/color_tile.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  final List<String> _pages = [
    'Главная',
    'Оценки',
    'Задания',
    'Расписание',
  ];

  @override
  Widget build(BuildContext context) {
    TimeOfDay _timeNofitications =
        Provider.of<SettingsProvider>(context).timeNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        children: <Widget>[
          ListTile(
            title: Text('Напоминание'),
            trailing: Switch(
              activeColor: kColorRed,
              value: Provider.of<SettingsProvider>(context).turnNotification(),
              onChanged: (val) async {
                if (val == true) {
                  await enableNotification(
                    Time(
                      _timeNofitications.hour,
                      _timeNofitications.minute,
                      0,
                    ),
                  );
                } else {
                  await flutterLocalNotificationsPlugin.cancel(0);
                }
                await Provider.of<SettingsProvider>(context, listen: false)
                    .turningNotification(val);
              },
            ),
          ),
          Provider.of<SettingsProvider>(context).turnNotification()
              ? ListTile(
                  title: Text('Время напоминания'),
                  trailing: Text(
                    '${Provider.of<SettingsProvider>(context).timeNotification().hour}'
                    ':'
                    '${Provider.of<SettingsProvider>(context).timeNotification().minute}',
                  ),
                  onTap: () async {
                    TimeOfDay _time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (_time == null) {
                      await Provider.of<SettingsProvider>(context,
                              listen: false)
                          .setTimeNotification(TimeOfDay.now());

                      await enableNotification(
                        Time(
                          TimeOfDay.now().hour,
                          TimeOfDay.now().minute,
                          0,
                        ),
                      );
                    } else {
                      await enableNotification(
                        Time(
                          _time.hour,
                          _time.minute,
                          0,
                        ),
                      );
                      await Provider.of<SettingsProvider>(context,
                              listen: false)
                          .setTimeNotification(_time);
                    }
                  },
                )
              : const SizedBox.shrink(),
          // TODO: сделать смену цветовой гаммы
          // ListTile(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (ctx) => AlertDialog(
          //         title: Text('Тема'),
          //         content: GridView.count(
          //           shrinkWrap: true,
          //           crossAxisCount: 5,
          //           crossAxisSpacing: 10,
          //           mainAxisSpacing: 10,
          //           children: <Widget>[
          //             ColorTile(color: Colors.red),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.grey),
          //             ColorTile(color: Colors.indigo),
          //             ColorTile(color: Colors.yellow),
          //             ColorTile(color: Colors.lime),
          //             ColorTile(color: Colors.orange),
          //             ColorTile(color: Colors.pink),
          //             ColorTile(color: Colors.teal),
          //             ColorTile(color: Colors.black),
          //             ColorTile(color: Colors.cyan),
          //             ColorTile(color: Colors.blue),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.green),
          //             ColorTile(color: Colors.green),
          //           ],
          //         ),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text('Закрыть'),
          //             onPressed: () => Navigator.of(context).pop(),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   title: Text('Сменить тему'),
          //   trailing: Container(
          //     width: 30,
          //     height: 30,
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: kBorderRadius,
          //     ),
          //   ),
          // ),
          // TODO: сделать смену режима
          // ListTile(
          //   title: Text('Темный режим'),
          //   trailing: Container(
          //     child: Text('Авто.'),
          //   ),
          // ),
          // TODO: сделать смену начального экрана
          ListTile(
            title: Text('Начальный экран'),
            trailing: Container(
              child: Text(
                _pages[Provider.of<SettingsProvider>(context).getStartPage],
              ),
            ),
            onTap: () async {
              int _page = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Выберите страницу'),
                    content: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_pages[index]),
                          dense: true,
                          onTap: () {
                            Navigator.of(context).pop(index);
                          },
                        );
                      },
                    ),
                  );
                },
              );
              await Provider.of<SettingsProvider>(context, listen: false)
                  .setStartPage(_page);
            },
          ),
          // TODO: сделать кнопку "Оставить отзыв"
          // ListTile(
          //   title: Text('Оставить отзыв'),
          // ),
          // TODO: сделать получение данных о приложении (версия, номер сборки)
          ListTile(
            title: Text('О приложении'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AboutDialog(
                    applicationName: 'Школьный дневник',
                    applicationVersion: '4.0.0',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future enableNotification(Time time) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '0',
      'Сбор рюкзака',
      'remindAboutPackBag',
      // enableVibration: true,
      // enableLights: true,
      // playSound: true,
      // visibility: NotificationVisibility.Public,
    );
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'show daily title',
      'Daily notification shown at approximately',
      time,
      platformChannelSpecifics,
    );
  }
}
