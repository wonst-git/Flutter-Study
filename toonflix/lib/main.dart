import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/screens/webtoon_detail_screen.dart';
import 'package:toonflix/screens/webtoon_webview_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.screenId,
      routes: {
        HomeScreen.screenId: (context) => HomeScreen(),
        WebtoonDetail.screenId: (context) => WebtoonDetail(model: ModalRoute.of(context)?.settings.arguments as WebtoonModel?),
        WebtoonWebview.screenId: (context) => WebtoonWebview(url: ModalRoute.of(context)?.settings.arguments as String?),
      },
      home: HomeScreen(),
    );
  }
}
