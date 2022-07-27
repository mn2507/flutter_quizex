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
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.symmetric(vertical: 10),
          primary: answerText == correctAnswer && answered
              ? Colors.green
              : Colors.orange,
          onPrimary: Colors.white,
          alignment: Alignment.center,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: selectHandler,
        child: Text(unescape.convert(answerText)),
      ),
    );
  }
}
