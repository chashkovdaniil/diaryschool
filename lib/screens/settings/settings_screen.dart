import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _pages = [
      tr('homeNav'),
      tr('gradesNav'),
      tr('tasksNav'),
      tr('timetableNav'),
    ];
    final List<Map<String, String>> languages = [
      {
        'locale': 'en-US',
        'lang': 'English',
      },
      {
        'locale': 'ru-RU',
        'lang': 'Русский',
      },
      {
        'locale': 'ru-UA',
        'lang': 'Український',
      },
      {
        'locale': 'ru-CV',
        'lang': 'Чӑвашла',
      },
    ];
    TimeOfDay _timeNofitications =
        Provider.of<SettingsProvider>(context).timeNotification();

    Locale getLanguage = Provider.of<SettingsProvider>(context).getLanguage;
    int getStartPage = Provider.of<SettingsProvider>(context).getStartPage;
    bool turnNotification =
        Provider.of<SettingsProvider>(context).turnNotification();
    TimeOfDay timeNotification =
        Provider.of<SettingsProvider>(context).timeNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        children: <Widget>[
          ListTile(
            title: Text(tr('notification')),
            trailing: Switch(
              activeColor: kColorRed,
              value: turnNotification,
              onChanged: (val) async {
                if (val == true) {
                  await enableNotification(
                    context,
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
          turnNotification
              ? ListTile(
                  title: Text(tr('timeNotification')),
                  trailing: Text(
                    '${timeNotification.hour}'
                    ':'
                    '${timeNotification.minute}',
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
                        context,
                        Time(TimeOfDay.now().hour, TimeOfDay.now().minute, 0),
                      );
                      return;
                    }
                    await enableNotification(
                      context,
                      Time(_time.hour, _time.minute, 0),
                    );
                    await Provider.of<SettingsProvider>(context, listen: false)
                        .setTimeNotification(_time);
                    return;
                  },
                )
              : const SizedBox.shrink(),
          ListTile(
            title: Text(tr('startScreen')),
            trailing: Container(
              child: Text(
                _pages[getStartPage],
              ),
            ),
            onTap: () async {
              int _page = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text(tr('selectPage')),
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
          ListTile(
            title: Text(tr('language')),
            trailing: Text(getLanguage.countryCode),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(tr('language')),
                    content: ListView.builder(
                      shrinkWrap: true,
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(languages[index]['lang']),
                          onTap: () {
                            Locale _locale = Locale(
                              languages[index]['locale'].split('-')[0],
                              languages[index]['locale'].split('-')[1],
                            );
                            Provider.of<SettingsProvider>(
                              context,
                              listen: false,
                            ).setLanguage(_locale);
                            context.locale = _locale;
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                    actions: [
                      FlatButton(
                        child: Text(tr('close')),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text(tr('aboutApp')),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AboutDialog(
                    applicationName: 'diaryschool',
                    applicationVersion: '4.0.0',
                    applicationIcon: SvgPicture.asset(
                      'assets/svg/Icon.svg',
                      width: 48,
                      height: 48,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future enableNotification(BuildContext context, Time time) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '0',
      tr('packingBag'),
      tr('notification'),
      enableVibration: true,
      enableLights: true,
      playSound: true,
      visibility: NotificationVisibility.Public,
    );
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        const IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      tr('timePackBag'),
      tr('packBag'),
      time,
      platformChannelSpecifics,
    );
  }
}

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
// TODO: сделать кнопку "Оставить отзыв"
// ListTile(
//   title: Text('Оставить отзыв'),
// ),
// TODO: сделать получение данных о приложении (версия, номер сборки)
