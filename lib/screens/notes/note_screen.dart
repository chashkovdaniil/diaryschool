import 'package:diaryschool/models/note.dart';
import 'package:diaryschool/provider/NotesProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/utilities/Extensions.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen({Key key, Map<String, dynamic> data})
      : note = Note.fromMap(data ?? {'date': DateTime.now()}),
        super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('note')),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                DateTime newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2030),
                );
                widget.note.date =
                    newDate ?? widget.note.date ?? DateTime.now();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      tr('date') + ': ',
                      style: theme.textTheme.subtitle1.copyWith(
                            color: theme.primaryColor,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.note.date.dmyStr),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.note.title,
                onChanged: (val) {
                  widget.note.title = val;
                },
                validator: (val) {
                  return val.isEmpty ? tr('fillField') : null;
                },
                maxLines: 1,
                maxLength: 30,
                decoration: InputDecoration(
                  isDense: true,
                  counter: const SizedBox.shrink(),
                  hintText: tr('enterTitle'),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.note.content,
                  onChanged: (val) {
                    widget.note.content = val;
                  },
                  validator: (val) {
                    return val.isEmpty ? tr('fillField') : null;
                  },
                  decoration: InputDecoration(
                    hintText: tr('enterText'),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  maxLengthEnforced: true,
                ),
              ),
            ),
            BottomAppBar(
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Provider.of<NotesProvider>(
                            context,
                            listen: false,
                          ).put(widget.note);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        tr('save'),
                        style: theme.textTheme.button.copyWith(
                              color: theme.colorScheme.surface,
                            ),
                      ),
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
