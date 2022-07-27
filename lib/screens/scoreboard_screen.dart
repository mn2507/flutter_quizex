import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/resultsProvider.dart';
import 'package:quizex_flutter/widgets/scoreboard_item.dart';

class ScoreboardScreen extends StatefulWidget {
  static const routeName = '/scoreboard';

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  ResultsStatus _resultsStatus;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _resultsStatus = ResultsStatus.LOADING;
      });
      Provider.of<ResultsProvider>(context).getResults().then((_) {
        setState(() {
          _resultsStatus = ResultsStatus.DONE;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final resultsData = Provider.of<ResultsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
      ),
      body: resultsData.items.isNotEmpty
          ? _resultsStatus != ResultsStatus.LOADING
              ? ListView.builder(
                  itemCount: resultsData.items.length,
                  itemBuilder: (ctx, i) => ScoreboardItem(resultsData.items[i]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text('No scores have been recorded.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
              ),
          ),
    );
  }
}
