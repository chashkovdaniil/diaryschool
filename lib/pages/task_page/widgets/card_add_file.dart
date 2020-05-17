import 'package:diaryschool/utilities/linearicons.dart';
import 'package:flutter/material.dart';

class CardAddFile extends StatelessWidget {
  CardAddFile({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140,
        height: 90,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: IconButton(
          icon: Icon(Linearicons.file_add, color: Colors.white), onPressed: (){

          }),),
      );
  }
}