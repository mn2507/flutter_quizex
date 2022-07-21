import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function
      resetHandler; // Change Function to VoidCallback if face any error

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awesome and innocent!';
    } else if (resultScore <= 12) {
      resultText = 'Pretty likeable!';
    } else if (resultScore <= 16) {
      resultText = 'You are... strange?!';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            child: Text('Restart Quiz!'),
            style: TextButton.styleFrom(primary: Colors.orange),
            onPressed: resetHandler,
          ),

          // FlatButton(
          //   child: Text('Restart Quiz!'),
          //   textColor: Colors.blue,
          //   onPressed: resetHandler,
          // )

          // OutlinedButton(
          //   child: Text('Restart Quiz!'),
          //   style: OutlinedButton.styleFrom(
          //          primary: Colors.orange,
          //          side: BorderSide(color: Colors.orange)),
          //   onPressed: resetHandler,
          // )
        ],
      ),
    );
  }
}
