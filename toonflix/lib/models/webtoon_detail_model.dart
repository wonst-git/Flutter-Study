class WebtoonDetailModel {
  final String? title, about, genre, age, thumb;

  WebtoonDetailModel({this.title, this.about, this.genre, this.age, this.thumb});

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'],
        thumb = json['thumb'];

  Map<String, dynamic> toJson() => {'title': title, 'about': about, 'genre': genre, 'age': age, 'thumb': thumb};

  @override
  String toString() => 'title: $title, about: $about, genre: $genre, age: $age, thumb: $thumb';
}
