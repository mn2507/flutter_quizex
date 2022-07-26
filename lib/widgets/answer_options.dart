import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class AnswerOptions extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  final String correctAnswer;
  final bool answered;

  AnswerOptions({
    this.selectHandler,
    this.answerText,
    this.correctAnswer,
    this.answered,
  });

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: answerText == correctAnswer && answered
            ? ElevatedButton.styleFrom(
                primary: Colors.green, onPrimary: Colors.white)
            : ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.white),
        onPressed: selectHandler,
        child: Text(unescape.convert(answerText)),
      ),
    );
  }
}
