class WebtoonEpisodeModel {
  final String? id, title, rating, date;

  WebtoonEpisodeModel({this.id, this.title, this.rating, this.date});

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'rating': rating, 'date': date};

  @override
  String toString() => 'id: $id, title: $title, rating: $rating, date: $date';
}
