import 'package:flutter/material.dart';
import 'package:practice_flutter_movie/models/movie_detail_model.dart';
import 'package:practice_flutter_movie/services/api_service.dart';

class DetailScreen extends StatelessWidget {
  late int movieId;
  DetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final Future<MovieDetailModel> detail =
        ApiService().getMovieDetail(movieId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    snapshot.data!.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Image(
                        height: 480,
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${snapshot.data!.poster}'))),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Rate Averaged : ${snapshot.data!.rate}',
                        style: TextStyle(fontSize: 15, color: Colors.black45))),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    children: <Widget>[
                      for (var genre in snapshot.data!.genres)
                        Text(
                          '${genre['name']} ',
                          style: TextStyle(fontSize: 15, color: Colors.black45),
                        )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Text(
                    snapshot.data!.overview,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
