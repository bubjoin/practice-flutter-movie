class MovieModel {
  final int id;
  final String title;
  final String poster;
  final dynamic rate;
  final List<dynamic> genreIds;
  final String release;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        poster = json['poster_path'],
        rate = json['vote_average'],
        genreIds = json['genre_ids'],
        release = json['release_date'];
}
