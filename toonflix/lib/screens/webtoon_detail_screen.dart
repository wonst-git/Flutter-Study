import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/component/skeleton.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/webtoon_webview_screen.dart';
import 'package:toonflix/services/http_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ]),
                    child: Hero(
                      tag: "thumbnail${widget.model?.id}",
                      child: Image.network(
                        widget.model?.thumb ?? "",
                        headers: const {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Whale/3.22.205.18 Safari/537.36"},
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 3,
                  child: FutureBuilder(
                    future: webtoon,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          const SizedBox(height: 6),
                          snapshot.data == null ? const Skeleton(width: 50, height: 20) : Text("${snapshot.data?.genre} / ${snapshot.data?.age}"),
                          const SizedBox(height: 6),
                          snapshot.data == null ? const Skeleton(width: 200, height: 60) : Text(snapshot.data?.about ?? ""),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data?[index];

                    return InkWell(
                      onTap: () {
                        onClick("https://comic.naver.com/webtoon/detail?titleId=${widget.model?.id}&no=${data?.id}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data?.title ?? ""),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          Text(data?.rating ?? ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(data?.date ?? ""),
                                const Icon(
                                  Icons.arrow_right_rounded,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onClick(String? url) {
    if (Platform.isAndroid || Platform.isIOS) {
      Navigator.of(context).pushNamed(WebtoonWebview.screenId, arguments: url);
    } else {
      launchUrlString(url ?? "");
    }
  }
}
