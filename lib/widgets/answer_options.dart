import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class AnswerOptions extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  AnswerOptions(
    this.selectHandler,
    this.answerText,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.orange, onPrimary: Colors.white),
        // ButtonStyle(
        //    backgroundColor: MaterialStateProperty.all(Colors.orange),
        //    foregroundColor: MaterialStateProperty.all(Colors.white)
        // ),
        child: Text(answerText),
        onPressed: selectHandler,
      ),

      // RaisedButton(
      //   color: Colors.blue,
      //   textColor: Colors.white,
      //   child: Text(answerText),
      //   onPressed: selectHandler,
      // ),
    );
  }
}
