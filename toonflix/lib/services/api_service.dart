import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:toonflix/models/webtoon_model.dart';

part 'api_service.g.dart';

const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
const String today = "/today";

@RestApi(baseUrl: baseUrl)
abstract class ApiRepository {
  factory ApiRepository(Dio dio, {String? baseUrl}) = _ApiRepository;

  @GET(today)
  Future<List<WebtoonModel>> getTodaysToons();
}

@JsonSerializable()
class Toon {
  String? title;
  String? thumb;
  String? id;

  Toon({this.title, this.thumb, this.id});

  factory Toon.fromJson(Map<String, dynamic> json) => _$ToonFromJson(json);

  Map<String, dynamic> toJson() => _$ToonToJson(this);
}
