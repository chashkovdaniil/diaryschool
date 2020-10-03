import 'package:diaryschool/models/note.dart';
import 'package:diaryschool/provider/NotesProvider.dart';
import 'package:diaryschool/screens/notes/note_screen.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Note> _notes = context.watch<NotesProvider>().notes;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('notes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      body: _notes.isEmpty
          ? Center(
              child: Text(
                tr('emptyList'),
                style: theme.textTheme.subtitle1,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(kDefaultPadding),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: kBorderRadius,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(
                            data: _notes[index].toMap,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      _notes[index].title,
                      style: theme.textTheme.subtitle1.copyWith(
                            color: theme.primaryColor,
                          ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<NotesProvider>().delete(_notes[index].uid);
                      },
                    ),
                    subtitle: Text(
                      _notes[index].content,
                      maxLines: 5,
                    ),
                  ),
                );
              },
              itemCount: _notes.length,
            ),
    );
  }
}
