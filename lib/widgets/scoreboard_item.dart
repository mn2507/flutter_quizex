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
          SizedBox(
            height: 180,
            child: Column(
              children: [
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
                 Chip(
                    label: Text(
                      widget.result.chosenCategory,
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Chip(
                          label: Text(
                            widget.result.chosenDifficulty,
                            style: TextStyle(
                              color: Theme.of(context).primaryTextTheme.headline6.color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Chip(
                          label: Text(
                            widget.result.chosenType,
                            style: TextStyle(
                              color: Theme.of(context).primaryTextTheme.headline6.color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
