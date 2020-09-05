import 'package:diaryschool/models/homework.dart';
import 'package:diaryschool/models/subject.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:diaryschool/provider/SubjectProvider.dart';
import 'package:diaryschool/common_widgets/select_subject_dialog.dart';

class SubjectField extends FormField<int> {
  SubjectField({
    Key key,
    BuildContext context,
    int initialValue,
    FormFieldValidator validator,
    @required Homework homework,
  }) : super(
          key: key,
          validator: validator,
          builder: (FormFieldState<int> state) {
            List<Subject> subjects =
                Provider.of<SubjectProvider>(context).values;
            ThemeData theme = Theme.of(context);
            
            return InkWell(
              onTap: () async {
                int _subject = await showDialog(
                  context: context,
                  builder: (context) => SelectSubjectDialog(
                    context: context,
                  ),
                );

                state.didChange(_subject);
                if (_subject != null) {
                  homework.subject = _subject;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  children: [
                    state.hasError
                        ? Text(
                            state.errorText,
                            style: theme.textTheme.bodyText2
                                .copyWith(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: <Widget>[
                        Text(
                          '${tr('subject')}:',
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: kBorderRadius,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    subjects.isEmpty
                                        ? tr('addSubject')
                                        : subjects[homework.subject ?? 0].title,
                                    style: theme.textTheme.headline6,
                                    maxLines: 1,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
