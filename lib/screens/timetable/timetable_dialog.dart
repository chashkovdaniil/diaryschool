import 'package:diaryschool/common_widgets/select_subject_dialog.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/timetable_row.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TimetableProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimetableDialog extends StatefulWidget {
  final TimetableRow timetable;
  TimetableDialog({Key key, TimetableRow timetable})
      : timetable = TimetableRow.fromMap(timetable.toMap()) ?? TimetableRow(),
        super(key: key);

  @override
  _TimetableDialogState createState() => _TimetableDialogState();
}

class _TimetableDialogState extends State<TimetableDialog> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'timetableDialog');
  @override
  Widget build(BuildContext context) {
    Subject subject = Provider.of<SubjectProvider>(context)
                                  .subject(widget.timetable.subject);
    return AlertDialog(
      title: Text(tr('timetableNav')),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            FormField<TimeOfDay>(
              initialValue: widget.timetable.start,
              validator: (value) {
                if (value == null) {
                  return tr('fillField');
                }
                if (value.hour >= widget.timetable.end.hour && value.minute >= widget.timetable.end.minute) {
                  // TODO: translate
                  return 'Время начала должно быть раньше времени окончания';
                }
                return null;
              },
              builder: (state) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay _start = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (_start != null) {
                          widget.timetable.start = _start;
                          state.didChange(_start);
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.timetable.start == null
                              ? tr('startLesson')
                              : '${tr('beginning')} - ${widget.timetable.start.hour}:${widget.timetable.start.minute}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    state.hasError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              state.errorText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.red),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
            FormField<TimeOfDay>(
              initialValue: widget.timetable.end,
              validator: (value) {
                return (value == null) ? tr('fillField') : null;
              },
              builder: (state) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay _end = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (_end != null) {
                          widget.timetable.end = _end;
                          state.didChange(_end);
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.timetable.end == null
                              ? tr('endLesson')
                              : '${tr('end')} - ${widget.timetable.end.hour}:${widget.timetable.end.minute}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    state.hasError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              state.errorText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.red),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
            FormField<int>(
              initialValue: widget.timetable.subject,
              validator: (int value) {
                return (value == null) ? tr('selectSubject') : null;
              },
              builder: (state) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        int _subject = await showDialog<int>(
                          context: context,
                          builder: (context) {
                            return SelectSubjectDialog(context: context);
                          },
                        );
                        if (_subject != null) {
                          widget.timetable.subject = _subject;
                          state.didChange(_subject);
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.timetable.subject == null
                              ? tr('selectSubject')
                              : subject
                                  .title,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    state.hasError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              state.errorText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.red),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('cancel').toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              // TODO: сделать проверку на чередуемость времени

              Provider.of<TimetableProvider>(
                context,
                listen: false,
              ).put(
                widget.timetable,
              );
              return Navigator.of(context).pop();
            }
          },
          child: Text(tr('save').toUpperCase()),
        ),
      ],
    );
  }
}
