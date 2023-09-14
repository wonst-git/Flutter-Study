import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HttpService {

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl$today');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      List<WebtoonModel> result = [];
      for (var webtoon in webtoons) {
        result.add(WebtoonModel.fromJson(webtoon));
      }
      return result;
    }
    throw Error();
  }
}