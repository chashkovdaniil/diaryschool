
import 'dart:async';

import 'package:diaryschool/pages/task_page/args.dart';
import 'package:diaryschool/pages/task_page/widgets/files_task_page.dart';
import 'package:diaryschool/utilities/constants.dart';
import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> files = ['/src/1.img', '/src/2.img','/src/3.img',];

  StreamController<bool> isEditController = StreamController<bool>.broadcast();

  @override
  void dispose() {
    isEditController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskPageArgs args = ModalRoute.of(context).settings.arguments as TaskPageArgs;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: StreamBuilder<bool>(
          initialData: false,
          stream: isEditController.stream,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: () {
                isEditController.add(!snapshot.data);
              },
              backgroundColor: kBackgroundColorTaskPage,
              child: Icon(
                snapshot.data ? Icons.check : Linearicons.pencil, 
                color: kPrimaryColorText
              )
            );
          }
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 170,
              color: kBackgroundColorTaskPage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Linearicons.arrow_left,
                          color: kPrimaryColorText
                        ), 
                        onPressed: (){
                          Navigator.pop(context);
                        }),
                      Text(
                        'Название предмета ${args.titleSubject}',
                        style: TextStyle(
                          color: kPrimaryColorText
                        ),
                      )  
                    ]
                  ),
                  FilesTaskPage(files ?? []),
                ],
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Дата: 27.01.2002'),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                color: kBackgroundColorTaskPage,
                                onPressed: () {
                                  // TODO: ok
                                },
                                child: const Text(
                                  'Задание выполнено',
                                  style: TextStyle(
                                    color: kPrimaryColorText
                                  ),
                                ))
                            ],
                          ),
                          const Text(
                            '5',
                            style: TextStyle(
                              fontSize: 50,
                              color: kPrimaryColorText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 150 - 150,
                        child: StreamBuilder<bool>(
                          initialData: false,
                          stream: isEditController.stream,
                          builder: (context, snapshot) {
                            return TextField(
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none
                              ),
                              enabled: snapshot.data,
                              minLines: null,
                              maxLines: null,
                              expands: true,
                            );
                          }
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
          ]
        ),
    ));
  }
}