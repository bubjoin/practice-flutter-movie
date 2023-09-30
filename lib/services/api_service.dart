import 'dart:convert';
import 'package:http/http.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

class ApiService {
  final String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String popular = 'popular';
  final String nowPlaying = 'now-playing';
  final String comingSoon = 'coming-soon';
  final String detail = 'movie?id=';

  Future<MovieDetailModel> getMovieDetail(int id) async {
    final url = Uri.parse('$baseUrl/$detail$id');
    final response = await get(url);
    if (response.statusCode == 200) {
      final MovieDetailModel movieDetail =
          MovieDetailModel.fromJson(jsonDecode(response.body));
      //print(movieDetail.title);
      return movieDetail;
    }
    throw Error();
  }

  Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      // print(movieInstances);
      return movieInstances;
    }
    throw Error();
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }
}
