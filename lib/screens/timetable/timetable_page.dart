import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/timetable_row.dart';
import 'package:diaryschool/provider/SettingsProvider.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TimetableProvider.dart';
import 'package:diaryschool/screens/timetable/timetable_dialog.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  OverlayEntry _overlayEntry;
  TabController daysController;

  @override
  void initState() {
    daysController = TabController(
        length: 7, vsync: this, initialIndex: DateTime.now().weekday - 1);
    super.initState();
  }

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
      if (element.dayOfWeek == daysController.index) {
        return true;
      }
      return false;
    }).toList();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('timetableNav'),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            controller: daysController,
            labelColor: theme.primaryColor,
            labelStyle:
                theme.textTheme.headline6.copyWith(color: theme.primaryColor),
            unselectedLabelStyle:
                theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w400),
            onTap: (day) => setState(() {}),
            tabs: List.generate(
              7,
              (index) => Tab(
                text: tr(daysOfWeek[index]),
              ),
            ),
          ),
          _timetable.isEmpty
              ? Expanded(
                  child: Center(child: Text(tr('noTimetable'))),
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
                            ? theme.primaryColor.withOpacity(0.1)
                            : theme.colorScheme.background,
                        child: TimetableTile(
                          timetableRow: _timetable[index],
                          index: index,
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
                      dayOfWeek: daysController.index,
                    ),
                  );
                },
              );
              setState(() {});
            },
            icon: Icon(Icons.add, color: theme.primaryColor),
            label: Text(
              tr('add').toUpperCase(),
              style: theme.textTheme.button.copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry firstRun(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        ThemeData theme = Theme.of(context);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('tipTimetable'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.subtitle1,
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
                      tr('close'),
                      style: theme.textTheme.button,
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

class TimetableTile extends StatelessWidget {
  const TimetableTile({
    Key key,
    @required int index,
    @required TimetableRow timetableRow,
  })  : _timetableRow = timetableRow,
        _index = index,
        super(key: key);

  final int _index;
  final TimetableRow _timetableRow;

  @override
  Widget build(BuildContext context) {
    Subject subject =
        Provider.of<SubjectProvider>(context).subject(_timetableRow.subject);

    return ListTile(
      leading: Text((_index + 1).toString()),
      title: Text(
        subject.title,
      ),
      subtitle: Text('${_timetableRow.start.hour}'
          ':${_timetableRow.start.minute < 10 ? '0' + _timetableRow.start.minute.toString() : _timetableRow.start.minute}'
          ' - ${_timetableRow.end.hour}'
          ':${_timetableRow.end.minute < 10 ? '0' + _timetableRow.end.minute.toString() : _timetableRow.end.minute}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          context.read<TimetableProvider>().delete(_timetableRow.uid);
        },
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return TimetableDialog(timetable: _timetableRow);
          },
        );
      },
    );
  }
}
