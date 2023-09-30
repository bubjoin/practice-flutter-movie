class MovieDetailModel {
  final int id;
  final String title;
  final String poster;
  final dynamic rate;
  final String overview;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        poster = json['poster_path'],
        rate = json['vote_average'],
        overview = json['overview'],
        genres = json['genres'];
}
