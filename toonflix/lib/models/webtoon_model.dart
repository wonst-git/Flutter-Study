class WebtoonModel {
  String? title;
  String? thumb;
  String? id;

  WebtoonModel({this.title, this.thumb, this.id});

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'title': title, 'thumb': thumb, 'id': id
  };

  @override
  String toString() => 'title: $title, thumb: $thumb, id: $id';
}
