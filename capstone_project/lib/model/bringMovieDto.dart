class BringMovieDto {
  List<Scenario> scenarios;

  BringMovieDto({required this.scenarios});

  BringMovieDto.fromJson(Map<String, dynamic> json)
      : scenarios = (json['movies'] as List)
            .map((e) => Scenario.fromJson(e))
            .toList();
}

class Scenario {
  int id;
  String title;
  String movie;
  String thumbnailUrl;

  Scenario(this.id, this.title, this.movie, this.thumbnailUrl);

  Scenario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        movie = json['movie'],
        thumbnailUrl = json['thumbnail_url'];
}
