import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/component/card.dart';
import 'package:toonflix/services/http_service.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  static const String screenId = '/homeScreen';

  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = HttpService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
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
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty == true) {
            return webtoonGridView(snapshot);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GridView webtoonGridView(AsyncSnapshot<List<WebtoonModel>> snapshot) => GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          var webtoon = snapshot.data?[index];

          return WebtoonCard(title: webtoon?.title ?? "", thumb: webtoon?.thumb ?? "", id: webtoon?.id ?? "");
        },
        itemCount: snapshot.data?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5/8),
      );
}
