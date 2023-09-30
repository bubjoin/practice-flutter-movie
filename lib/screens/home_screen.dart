import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter_movie/screens/detail_screen.dart';
import 'package:practice_flutter_movie/services/api_service.dart';
import 'package:practice_flutter_movie/models/movie_model.dart';
import 'package:practice_flutter_movie/models/movie_detail_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies =
      ApiService().getPopularMovies();
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService().getNowPlayingMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService().getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: true,
        title: const Text('Movie',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: const Text(
              'Popular Movies',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
          ),
          FutureBuilder(
            future: popularMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data!.sort((a, b) => a.rate.compareTo(b.rate));
                return makeListViewContainer(snapshot);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: const Text(
              'Now Playing',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ),
          FutureBuilder(
            future: nowPlayingMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data!.sort((a, b) => a.title.compareTo(b.title));
                return makeListViewContainer(snapshot);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
            child: const Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
          ),
          FutureBuilder(
            future: comingSoonMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data!.sort((a, b) => a.release.compareTo(b.release));
                return makeListViewContainer(snapshot);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Container makeListViewContainer(AsyncSnapshot<List<MovieModel>> snapshot) {
    return Container(
      // to prevent viewport error
      height: 250,
      child: ListView.separated(
        // was builder, was just listview
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var movie = snapshot.data![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      movieId: movie.id,
                    ),
                  ));
            },
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Image(
                      height: 220,
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${movie.poster}')),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    movie.title.length >= 17
                        ? movie.title
                            .replaceRange(17, movie.title.length, ' ...')
                        : movie.title,
                    style: const TextStyle(color: Colors.black87),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

/* //Fetch using state, async, await
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<MovieModel> popularMovies;
  late List<MovieModel> nowPlayingMovies;
  late List<MovieModel> comingSoonMovies;

  late MovieDetailModel movieDetail;

  bool isLoading = true;

  void waitForMovies() async {
    popularMovies = await ApiService().getPopularMovies();
    nowPlayingMovies = await ApiService().getNowPlayingMovies();
    comingSoonMovies = await ApiService().getComingSoonMovies();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text('Movie',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: Column(),
    );
  }
}
 */
