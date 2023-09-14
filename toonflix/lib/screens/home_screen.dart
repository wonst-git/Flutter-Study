import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/services/http_service.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {

  // List<WebtoonModel> webtoons = [];
  // bool isLoading = true;

  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = HttpService.getTodaysToons()
  // final dio = Dio();
  // final repository = ApiRepository(dio);
  //
  // repository.getTodaysToons().then((value) {
  //   for (var toon in value) {
  //     print(toon.toString());
  //   }
  // });

  // final httpService = HttpService();
  //
  // void waitForWebToons() async {
  //   webtoons = await HttpService.getTodaysToons();
  //   isLoading = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    // print(isLoading);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text('Today\'s 툰s'),
        titleTextStyle: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: FutureBuilder(
        initialData: [],
        future: webtoons,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Text("There is data!");
          } else {
            return Text("Loading...");
          }
        },
      ),
    );
  }
}
