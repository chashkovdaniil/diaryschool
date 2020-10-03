import 'package:diaryschool/common_widgets/select_teacher_dialog.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:diaryschool/models/teacher.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/provider/TeacherProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDialog extends StatefulWidget {
  final Subject subject;
  final int index;
  SubjectDialog({
    Key key,
    this.subject,
    this.index,
  }) : super(key: key);

  @override
  _SubjectDialogState createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'subjectDialog');
  @override
  Widget build(BuildContext context) {
    List<Teacher> teachers = context.watch<TeacherProvider>().values;
    ThemeData theme = Theme.of(context);

    return AlertDialog(
      title: Text(tr('subject')),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                return value.isEmpty ? tr('enterTitle') : null;
              },
              initialValue: widget.subject.title,
              decoration: InputDecoration(hintText: tr('subject')),
              onChanged: (value) {
                widget.subject.title = value;
              },
            ),
            TextFormField(
              initialValue: widget.subject.map,
              decoration: InputDecoration(hintText: tr('cabinet')),
              onChanged: (value) {
                setState(() {
                  widget.subject.map = value;
                });
              },
            ),
            FormField<int>(
              validator: (int value) {
                return value == null ? tr('enterTeacher') : null;
              },
              initialValue: widget.subject.teacher,
              builder: (state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        int _teacher = await showDialog(
                          context: context,
                          builder: (ctx) => SelectTeacherDialog(context: ctx),
                        );
                        if (_teacher != null) {
                          widget.subject.teacher = _teacher;
                          state.didChange(widget.subject.teacher);
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
                              color: theme.colorScheme.onBackground
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.subject.teacher == null
                              ? tr('teacher')
                              : teachers[widget.subject.teacher].toString(),
                          overflow: TextOverflow.fade,
                          // style: Theme.of(context).textTheme,
                        ),
                      ),
                    ),
                    state.hasError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              state.errorText,
                              style: theme
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.red),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('cancel').toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Provider.of<SubjectProvider>(
                context,
                listen: false,
              ).put(
                widget.subject,
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
