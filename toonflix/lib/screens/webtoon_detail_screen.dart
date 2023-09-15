import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/component/skeleton.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/http_service.dart';

class WebtoonDetail extends StatefulWidget {
  static const String screenId = '/webtoonDetailScreen';
  final WebtoonModel? model;

  const WebtoonDetail({super.key, this.model});

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  late Future<WebtoonDetailModel?> webtoon = Future(() => null);
  late Future<List<WebtoonEpisodeModel>> episodes = Future(() => []);

  @override
  void initState() {
    super.initState();

    webtoon = HttpService.getToonDetail(widget.model?.id ?? "");
    episodes = HttpService.getEpisodes(widget.model?.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        centerTitle: true,
        title: Hero(
          tag: 'title${widget.model?.id}',
          child: Text(
            widget.model?.title ?? "",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
              wordSpacing: 0,
              letterSpacing: 0,
            ),
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Hero(
                  tag: "thumbnail${widget.model?.id}",
                  child: Image.network(
                    widget.model?.thumb ?? "",
                    headers: const {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Whale/3.22.205.18 Safari/537.36"},
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: FutureBuilder(
                    future: webtoon,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          const SizedBox(height: 6),
                          snapshot.data == null ? const Skeleton(width: 50, height: 20) : Text(snapshot.data?.age ?? ""),
                          const SizedBox(height: 6),
                          snapshot.data == null ? const Skeleton(width: 50, height: 20) : Text(snapshot.data?.genre ?? ""),
                          const SizedBox(height: 6),
                          snapshot.data == null ? const Skeleton(width: 200, height: 60) : Text(snapshot.data?.about ?? ""),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
