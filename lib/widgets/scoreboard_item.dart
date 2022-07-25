import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizex_flutter/providers/result.dart';

class ScoreboardItem extends StatefulWidget {
  Result result;

  ScoreboardItem(this.result);

  @override
  _ScoreboardItemState createState() => _ScoreboardItemState();
}

class _ScoreboardItemState extends State<ScoreboardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text.rich(
              TextSpan(
                text: 'Total score: ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.result.totalScore,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            subtitle: Text(widget.result.dateTime),
            trailing: Text.rich(
              TextSpan(
                text: 'Duration: ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.result.totalDuration,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
