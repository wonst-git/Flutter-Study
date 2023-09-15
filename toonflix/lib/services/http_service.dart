import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HttpService {
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      List<WebtoonModel> result = [];
      for (var webtoon in webtoons) {
        result.add(WebtoonModel.fromJson(webtoon));
      }
      return result;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonDetail(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    return response.statusCode == 200 ? WebtoonDetailModel.fromJson(jsonDecode(response.body)) : throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodes(String id) async {
    final url = Uri.parse('$baseUrl/$id$episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<WebtoonEpisodeModel> result = [];

      final episodes = jsonDecode(response.body);

      for (var episode in episodes) {
        result.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return result;
    }

    throw Error();
  }
}
