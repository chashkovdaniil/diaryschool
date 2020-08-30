import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/timetable_row.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TimetableProvider.dart';
import 'package:diaryschool/screens/timetable/timetable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  double _currentDay = 1;
  OverlayEntry _overlayEntry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<SettingsProvider>(context).getFirstRunTimetablePage &&
        Provider.of<int>(context) == 3) {
      _overlayEntry = firstRun(context);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Overlay.of(context).insert(_overlayEntry);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TimetableRow> _timetable =
        context.watch<TimetableProvider>().values.where((element) {
      if (element.dayOfWeek == _currentDay) {
        return true;
      }
      return false;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).timetableNav),
      ),
      body: Column(
        children: [
          Text(
            I18n.of(context).daysOfWeek[_currentDay.round() - 1],
            style: Theme.of(context).textTheme.headline6,
          ),
          _timetable.isEmpty
              ? Expanded(
                  child: Center(child: Text(I18n.of(context).noTimetable)),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _timetable.length,
                    itemBuilder: (context, index) {
                      bool _current = false;
                      if ((TimeOfDay.now().hour < _timetable[index].end.hour ||
                              (TimeOfDay.now().hour ==
                                      _timetable[index].end.hour &&
                                  TimeOfDay.now().minute <
                                      _timetable[index].end.minute)) &&
                          (TimeOfDay.now().hour >
                                  _timetable[index].start.hour ||
                              (TimeOfDay.now().hour ==
                                      _timetable[index].start.hour &&
                                  TimeOfDay.now().minute >
                                      _timetable[index].start.minute))) {
                        _current = true;
                      } else {
                        _current = false;
                      }
                      return Material(
                        color: _current
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Theme.of(context).colorScheme.background,
                        child: ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(
                            Provider.of<SubjectProvider>(context)
                                .values[_timetable[index].subject]
                                .title,
                          ),
                          subtitle: Text('${_timetable[index].start.hour}'
                              ':${_timetable[index].start.minute < 10 ? '0' + _timetable[index].start.minute.toString() : _timetable[index].start.minute}'
                              ' - ${_timetable[index].end.hour}'
                              ':${_timetable[index].end.minute < 10 ? '0' + _timetable[index].end.minute.toString() : _timetable[index].end.minute}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              context
                                  .read<TimetableProvider>()
                                  .delete(_timetable[index].uid);
                              setState(() {});
                            },
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TimetableDialog(
                                    timetable: _timetable[index]);
                              },
                            );
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
          // const Spacer(),
          FlatButton.icon(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return TimetableDialog(
                    timetable: TimetableRow(
                      dayOfWeek: _currentDay.round(),
                    ),
                  );
                },
              );
              setState(() {});
            },
            icon: const Icon(Icons.add),
            label: Text(I18n.of(context).add),
          ),
          Container(
            child: Slider.adaptive(
              value: _currentDay,
              onChanged: (val) {
                setState(() {
                  _currentDay = val;
                });
              },
              min: 1,
              max: 7,
              divisions: 6,
              label: I18n.of(context).daysOfWeek[_currentDay.round() - 1],
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry firstRun(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    I18n.of(context).tipTimetable,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<SettingsProvider>(
                        context,
                        listen: false,
                      ).setFirstRunTimetablePage();
                      _overlayEntry.remove();
                    },
                    child: Text(
                      I18n.of(context).close,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
