import 'package:diaryschool/generated/i18n.dart';
import 'package:diaryschool/models/homework.dart';
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: <Widget>[
                        Text(
                          '${I18n.of(context).subject}:',
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
                                    Provider.of<SubjectProvider>(context)
                                            .values
                                            .isEmpty
                                        ? I18n.of(context).addSubject
                                        : Provider.of<SubjectProvider>(context)
                                            .values[homework.subject ?? 0]
                                            .title,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    maxLines: 1,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).primaryColor,
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
