import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/note.dart';
import 'package:diaryschool/provider/NotesProvider.dart';
import 'package:diaryschool/utilities/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).note),
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
                  firstDate: DateTime(2020),
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
                      I18n.of(context).date + ': ',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Theme.of(context).primaryColor,
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
                  return val.isEmpty ? I18n.of(context).fillField : null;
                },
                maxLines: 1,
                maxLength: 30,
                decoration: InputDecoration(
                  isDense: true,
                  counter: const SizedBox.shrink(),
                  hintText: I18n.of(context).enterTitle,
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
                    return val.isEmpty ? I18n.of(context).fillField : null;
                  },
                  decoration: InputDecoration(
                    hintText: I18n.of(context).enterText,
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
                        I18n.of(context).save,
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                      ),
                      color: Theme.of(context).primaryColor,
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
