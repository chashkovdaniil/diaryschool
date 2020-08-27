import 'package:diaryschool/common_widgets/select_subject_dialog.dart' show SelectSubjectDialog;
import 'package:diaryschool/generated/i18n.dart' show I18n;
import 'package:diaryschool/models/timetable_row.dart' show TimetableRow;
import 'package:diaryschool/provider/SubjectProvider.dart' show SubjectProvider;
import 'package:diaryschool/provider/TimetableProvider.dart' show TimetableProvider;
import 'package:flutter/material.dart' show AlertDialog, Border, BorderSide, BoxDecoration, BuildContext, Colors, Column, Container, EdgeInsets, FlatButton, Form, FormField, FormState, GestureDetector, GlobalKey, Key, ListView, Navigator, Padding, SizedBox, State, StatefulWidget, Text, TextOverflow, Theme, TimeOfDay, Widget, showDialog, showTimePicker;
import 'package:provider/provider.dart';

class TimetableDialog extends StatefulWidget {
  TimetableRow timetable = TimetableRow();
  TimetableDialog({Key key, this.timetable}) : super(key: key);

  @override
  _TimetableDialogState createState() => _TimetableDialogState();
}

class _TimetableDialogState extends State<TimetableDialog> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'timetableDialog');
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18n.of(context).timetableNav),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            FormField<TimeOfDay>(
              initialValue: widget.timetable.start,
              validator: (value) {
                if (value == null) {
                  return I18n.of(context).fillField;
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
                              ? I18n.of(context).startLesson
                              : '${I18n.of(context).beginning} - ${widget.timetable.start.hour}:${widget.timetable.start.minute}',
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
                if (value == null) {
                  return I18n.of(context).fillField;
                }
                return null;
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
                              ? I18n.of(context).endLesson
                              : '${I18n.of(context).end} - ${widget.timetable.end.hour}:${widget.timetable.end.minute}',
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
                if (value == null) {
                  return I18n.of(context).selectSubject;
                }
                return null;
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
                              ? I18n.of(context).selectSubject
                              : Provider.of<SubjectProvider>(context)
                                  .values[widget.timetable.subject]
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
          child: Text(I18n.of(context).cancel.toUpperCase()),
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
          child: Text(I18n.of(context).save.toUpperCase()),
        ),
      ],
    );
  }
}
