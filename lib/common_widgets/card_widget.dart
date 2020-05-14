import 'package:diaryschool/utilities/constants.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String lesson;
  final int start, end;
  final String homework;
  final bool isDone;

  CardWidget({
    Key key,
    @required this.lesson,
    this.start,
    this.end,
    this.homework,
    this.isDone
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              start == null ? 
                const SizedBox.shrink() : 
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '8:00',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 37, 46, 101),
                      fontWeight: FontWeight.w800
                    ),
                  )
                ),
              // start == null ? 
              //   const SizedBox.shrink() : 
              //   Container(
              //     padding: const EdgeInsets.only(left: 20),
              //     child: Text(start.toString())
              //   ),
              end == null ? 
                const SizedBox.shrink() : 
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: const Text(
                    '40 минут',
                    style: TextStyle(
                      color: kAccentColorText,
                      fontWeight: FontWeight.w300
                    ),
                  )
                )
              
              // end == null ? 
              //   const SizedBox.shrink() : 
              //   Container(
              //     padding: const EdgeInsets.only(right: 20),
              //     child: Text((end - start).toString())
              //   )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 5, left: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)
              ),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,

              )
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            lesson,
                            maxLines: 1,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 37, 46, 101),
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          const SizedBox(width: 10),
                          isDone == null ?
                            const SizedBox.shrink() :
                            Icon(Icons.done, color: Colors.green)
                            
                            // Container(
                            //   width: 10,
                            //   height: 10,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            //     color: Colors.green
                            //   ),
                            // )
                        ],
                      ),
                      homework == null ? 
                        const SizedBox.shrink() : 
                        Column(
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Text(
                              homework,
                              maxLines: 10,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 139, 139, 148),
                              ),
                            ),
                          ],
                        ),
                    ]
                  )
                ),
                // Это галка, пока не реализована
                // LayoutBuilder(
                //   builder: (context, constraints) {
                //     print(constraints.biggest);
                //     return Container(
                //       // padding: const EdgeInsets.all(20),
                //       child: const Icon(Icons.done),
                //     );
                //   }
                // ),
              ],
            )
          )
        ],
      )
    );
  }
}