import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:quizex_flutter/providers/categoriesProvider.dart';
import 'package:quizex_flutter/providers/questionsProvider.dart';
import 'package:quizex_flutter/widgets/menu_options.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<CategoriesProvider>(
    //       create: (_) {
    //         return CategoriesProvider();
    //       },
    //     ),
    //     ChangeNotifierProvider<QuestionsProvider>(create: (_) {
    //       return QuestionsProvider();
    //     })
    //   ],
    //   child: const MenuOptions(),
    // );
  }
}
